//
//  LifePatternService.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/05/03.
//

import Combine
import Foundation

import Moya

class LifePatternServiceType {
    
}

class LifePatternService {
    
    private var provider: MoyaProvider<LifePatternAPI>
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
    func requestSaveLifePatterns() -> AnyPublisher<LifePatternResponseModel, LifePatternError> {
        let mid = UserDefaults.standard.integer(forKey: "mid")
        if mid <= 0 { fatalError("잘못된 접근입니다. 해당 API는 로그인된 상태에서 호출되어야합니다.") }
        
        return requestLastDate(mid: mid)
            .map { model -> Date in
                return self.getlastDateForCreateLifePattern(lastDate: model.response.lastDate)
            }
            .map { lastDate -> [Date] in
                return self.getDatesForCreateLifePatterns(lastDate: lastDate)
            }
            .map { dates -> [AnyPublisher<LifePatternModel, Never>] in
                return dates.compactMap { date -> AnyPublisher<LifePatternModel, Never> in
                    return self.createLifePatternModel(date: date)
                }
            }
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
            .mapError { _ in
                LifePatternError.sendFailed
            }
            .eraseToAnyPublisher()
        
    }
    
    
    /// mid에 해당하는 유저의 LifePattern 마지막 업데이트 일을 가져옵니다.
    /// - Parameter mid: 로그인된 유저 mid입니다.
    /// - Returns: 마지막 업데이트 날짜를 담은 모델을 반환합니다.
    func requestLastDate(mid: Int) -> AnyPublisher<ResponseModel<LastDateResponseModel>, Error> {
        
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
    // MARK: - Private functions
    
    /// LifePattern을 생성할 범위의 마지막 날짜 (오래전 날짜)를 구합니다.
    ///
    /// - Note: 만약 첫 업데이트(lastDate가 없다면)라면 120일 전을 마지막 날짜로 정합니다.
    /// - Parameter lastDate: 마지막 날짜를 전달받습니다. 없다면 nil을 받습니다.
    /// - Returns: 마지막 날짜를 Date형으로 반환합니다.
    private func getlastDateForCreateLifePattern(lastDate: String?) -> Date {
        if let lastModifiedDate = lastDate {
            return DateHelper.convertStringToDate(string: lastModifiedDate)
        } else {
            return DateHelper.subtractDays(from: Date(), days: 120)
        }
    }
    
    /// LifePattern을 생성할 범위에 해당하는 Date 배열을 생성합니다.
    /// - Parameter lastDate: 범위의 마지막 날짜를 받습니다.
    /// - Returns: Date 배열을 반환합니다.
    /// - Note: 범위의 시작 날짜는 오늘입니다.
    private func getDatesForCreateLifePatterns(lastDate: Date) -> [Date] {
        return DateHelper.generateBetweenDates(from: lastDate, to: Date())
    }
    
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
