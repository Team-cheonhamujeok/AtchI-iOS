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
        
    }
}

extension LifePatternService {
    private func createLifePatternModel(date: Date) {
//        getSleepHeartRateAverage(date: date).
    }
    
    func getSleepHeartRateAverage(date: Date) -> AnyPublisher<Double, HKError> {
        return sleepService.getSleepInterval(date: date)
            .flatMap { intervals -> AnyPublisher<Double, HKError> in
                
                let publishers = intervals.map {
                    self.heartRateService.getHeartRate(startDate: $0.startDate,
                                                       endDate: $0.endDate)
                }
                
                return Publishers.Sequence(sequence: publishers)
                    .flatMap { $0 }
                    .collect()
                    .map { values -> Double in
                        let result = values.flatMap { $0 }
                        return Double(result.reduce(0.0, +))/Double(result.count)
                    }
                    .eraseToAnyPublisher()
            }.eraseToAnyPublisher()
    }
    
//    
//    func getSleepHeartRateAverage2(date: Date) -> AnyPublisher<Double, HKError> {
//        let publishers = sleepService.getSleepInterval(date: date)
//            .flatMap { intervals in
//                
//                let publishers = intervals.map {
//                    self.heartRateService.getHeartRate(startDate: $0.startDate,
//                                                       endDate: $0.endDate)
//                }
//                
//                return Publishers.concatenateMany(publishers)
//                    .flatMap{ $0 }
//                    .collect()
//                    .map { values -> Double in
//                        let result = values.flatMap { $0 }
//                        return Double(result.reduce(0.0, +))/Double(result.count)
//                    }
//                    .eraseToAnyPublisher()
//            }.eraseToAnyPublisher()
//    }

}
