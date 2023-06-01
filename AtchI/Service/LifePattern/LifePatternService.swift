//
//  LifePatternService.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/05/03.
//

import Combine
import Foundation

import Moya

class LifePatternService {
    
    private var provider: MoyaProvider<LifePatternAPI> // FIXME: 주입으로 바꾸기
    
    private var sleepService: HKSleepServiceType
    private var activityService: HKActivityServiceProtocol
    private var heartRateService: HKHeartRateServiceType
    
    init(provider: MoyaProvider<LifePatternAPI>,
         sleepService: HKSleepServiceType,
         activityService: HKActivityServiceProtocol,
         heartRateService: HKHeartRateServiceType) {
        self.provider = provider
        self.sleepService = sleepService
        self.activityService = activityService
        self.heartRateService = heartRateService
    }
    
    /// 생활패턴 정보를 서버에 저장합니다.
    ///
    /// 내부 로직은 다음과 같습니다.
    /// 1. 서버에서 마지막 업데이트일 받아옵니다.
    ///     1-1. 만약 마지막 업데이트일이 없다면 120일 이전 데이터부터 추출합니다.
    /// 2. 마지막 업데이트일과 현재까지의 모든 날짜를 Date()형으로 저장합니다.
    /// 3. 각 날짜에 맞는 HealthKit 데이터를 추출하고 LifePatternModel로 만듭니다.
    /// 4. LifePatternModel들을 배열로 합쳐 서버에 저장합니다.
    ///
    /// - Returns: 요청 성공/실패에 대한 응답을 반환하는 퍼블리셔를 반환합니다.
    func requestPostLifePattern() -> AnyPublisher<LifePatternResponseModel, Error> {
        
        let mid = UserDefaults.standard.integer(forKey: "mid")
        if mid <= 0 { fatalError("잘못된 접근입니다. 해당 API는 로그인된 상태에서 호출되어야합니다.") }
        
        // 마지막 업데이트일 받아오기
        let lastDatePublisher = reuqestLastDate(mid: mid)
            .map { model in
                if let lastDate = model.response.lastDate {
                    return DateHelper.convertStringToDate(string: lastDate,
                                                          format: "yyyy-mm-dd")
                } else {
                    return DateHelper.subtractDays(from: Date(), days: 120)
                }
            }

        // 마지막 업데이트일과 오늘 사이의 모든 날짜에 대한 LifePatternModel구하기
        //  -> AnyPublisher<LifePatternModel, Never>
        let lifePatternPublisher = lastDatePublisher
            .replaceError(with: Date())
            .map { lastDate -> [AnyPublisher<LifePatternModel, Never>]  in
                // 사이의 모든 날짜 구하기
                let dates = DateHelper.generateBetweenDates(from: lastDate, to: Date())

                // Calendar와 DateComponents를 사용하여 100일 전(임시)의 날짜 계산
                return dates.compactMap { date -> AnyPublisher<LifePatternModel, Never>? in
                        return self.createLifePatternModel(date: date)
                    }
            }
            .replaceError(with: nil)
            .compactMap { $0 }
            .eraseToAnyPublisher()
        
        // LifePattern모델들을 배열로 합쳐서 서버에 푸시하기
        return lifePatternPublisher
            .flatMap {
                Publishers.MergeMany($0)
            }
            .collect()
            .flatMap { lifePatternModels in
                self.provider.requestPublisher(.sendLifePattern(lifePatternModels))
                    .tryMap { response -> LifePatternResponseModel in
                        return try response.map(LifePatternResponseModel.self)
                    }
                    .mapError { _ in
                        return LifePatternError.sendFailed
                    }
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
    
    func reuqestLastDate(mid: Int) -> AnyPublisher<ResponseModel<LastDateResponseModel>, Error> {
        
        // 마지막 업데이트일 받아오기
       return provider.requestPublisher(.lastDate(mid))
            .tryMap { response in
                return try response.map(ResponseModel<LastDateResponseModel>.self)
            }
            .mapError { _ in
                return LifePatternError.sendFailed
            }
            .eraseToAnyPublisher()
    }
}

extension LifePatternService {
    /// HKService조합해서 여러 값을 LifePatternModel로 묶습니다.
    private func createLifePatternModel(date: Date) -> AnyPublisher<LifePatternModel, Never> {
        let stepCountPub = activityService.getStepCount(date: date)
            .replaceError(with: -1.0)
        let sleepTotalPub = sleepService.getSleepRecord(date: date, sleepCategory: .total)
            .replaceError(with: -1)
        let heartAveragePub = getSleepHeartRateAverage(date: date)
            .replaceError(with: -1.0)
        let heartVariabilityPub = heartRateService.getHeartRateVariability(date: date)
            .replaceError(with: [])
        let mid = UserDefaults.standard.integer(forKey: "mid")
        if (mid == 0) { fatalError("잘못된 접근입니다. 로그인 후 이용 가능한 API입니다.") }
        
        return Publishers
            .Zip4(stepCountPub, sleepTotalPub, heartAveragePub, heartVariabilityPub)
            .map {
                LifePatternModel(
                    mid: mid,
                    date: date,
                    activity_steps: Int($0.0),
                    sleep_duration: $0.1,
                    sleep_hr_average: $0.2,
                    sleep_rmssd: $0.3)
            }
            .eraseToAnyPublisher()
    }
    
    /// 수면 심박 평균 구합니다.
    private func getSleepHeartRateAverage(date: Date) -> AnyPublisher<Double, HKError> {
        return sleepService.getSleepInterval(date: date)
            .flatMap { intervals -> AnyPublisher<Double, Never> in
                
                let publishers = intervals.map {
                    self.heartRateService.getHeartRateAveragePerMin(startDate: $0.startDate,
                                                       endDate: $0.endDate)
                    .replaceError(with: [])
                }
                
                return Publishers.MergeMany(publishers)
                    .collect()
                    .map { values -> Double in
                        let result = values.flatMap { $0 }
                        return Double(result.reduce(0.0, +))/Double(result.count)
                    }
                    .eraseToAnyPublisher()
            }.eraseToAnyPublisher()
    }
}
