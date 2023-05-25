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
    
    private var provider = MoyaProvider<LifePatternAPI>() // FIXME: 주입으로 바꾸기
    
    private var sleepService: HKSleepServiceType
    private var activityService: HKActivityServiceProtocol
    private var heartRateService: HKHeartRateServiceType
    
    init(sleepService: HKSleepServiceType,
         activityService: HKActivityServiceProtocol,
         heartRateService: HKHeartRateServiceType) {
        self.sleepService = sleepService
        self.activityService = activityService
        self.heartRateService = heartRateService
    }
    
    func requestPostLifePattern() -> AnyPublisher<LifePatternResponseModel, Error> {
        // 현재 날짜 가져오기
        let currentDate = Date()

        // Calendar와 DateComponents를 사용하여 100일 전(임시)의 날짜 계산
        let lifePatternPublishers = (0...100).reversed()
            .compactMap { subtractDay -> AnyPublisher<LifePatternModel, Never>? in
                var dateComponents = DateComponents()
                dateComponents.day = -subtractDay
                let calendar = Calendar.current
                guard let calculatedDate = calendar.date(byAdding: dateComponents, to: currentDate)
                else { return nil }
                
                return createLifePatternModel(date: calculatedDate)
            }
        
        return Publishers.MergeMany(lifePatternPublishers)
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
                    self.heartRateService.getHeartRate(startDate: $0.startDate,
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
