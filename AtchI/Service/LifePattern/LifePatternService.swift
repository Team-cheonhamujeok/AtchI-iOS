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
    
    private var provicer = MoyaProvider<LifePatternAPI>() // FIXME: 주입으로 바꾸기
    
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
    
    func requestPostLifePattern() {
        // .. API
        
        
    }
}

extension LifePatternService {
    /// HKService조합해서 여러 값을 LifePatternModel로 묶습니다.
    private func createLifePatternModel(date: Date)
    -> AnyPublisher<LifePatternModel, HKError>
    // TODO: 값 없을 시 NaN으로 채우는 로직 작성해야함
    {
        let stepCountPub = activityService.getStepCount(date: date)
        let sleepTotalPub = sleepService.getSleepRecord(date: date, sleepCategory: .total)
        let heartAveragePub = getSleepHeartRateAverage(date: date)
        let heartVariabilityPub = heartRateService.getHeartRateVariability(date: date)
        
        return Publishers
            .Zip4(stepCountPub, sleepTotalPub, heartAveragePub, heartVariabilityPub)
            .map {
                LifePatternModel(activity_steps: Int($0.0),
                                 sleep_duration: $0.1,
                                 sleep_hr_average: $0.2,
                                 sleep_rmssd: $0.3)
            }
            .eraseToAnyPublisher()
    }
    
    /// 수면 심박 평균 구합니다.
    func getSleepHeartRateAverage(date: Date) -> AnyPublisher<Double, HKError> {
        return sleepService.getSleepInterval(date: date)
            .flatMap { intervals -> AnyPublisher<Double, HKError> in
                
                let publishers = intervals.map {
                    self.heartRateService.getHeartRate(startDate: $0.startDate,
                                                       endDate: $0.endDate)
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
