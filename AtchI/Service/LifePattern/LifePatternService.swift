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
    
    func requestPostLifePattern() {
        // .. API
        
        
    }
}

extension LifePatternService {
    /// HKService조합해서 여러 값을 LifePatternModel로 묶습니다.
    func createLifePatternModel(date: Date) -> AnyPublisher<LifePatternModel, Never> {
        let stepCountPub = activityService.getStepCount(date: date)
            .replaceError(with: -1.0)
        let sleepTotalPub = sleepService.getSleepRecord(date: date, sleepCategory: .total)
            .replaceError(with: -1)
        let heartAveragePub = getSleepHeartRateAverage(date: date)
            .replaceError(with: -1.0)
        let heartVariabilityPub = heartRateService.getHeartRateVariability(date: date)
            .replaceError(with: [])
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateString = dateFormatter.string(from: date)
        
        return Publishers
            .Zip4(stepCountPub, sleepTotalPub, heartAveragePub, heartVariabilityPub)
            .map {
                LifePatternModel(date: dateString,
                                 activitySteps: Int($0.0),
                                 sleepDuration: $0.1,
                                 sleepHrAverage: $0.2,
                                 sleepRmssd: $0.3)
            }
            .eraseToAnyPublisher()
    }
    
    /// 수면 심박 평균 구합니다.
    func getSleepHeartRateAverage(date: Date) -> AnyPublisher<Double, HKError> {
        return sleepService.getSleepInterval(date: date)
            .print("interval: ")
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
