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
            .flatMap { interval -> AnyPublisher<Double, HKError> in
            let publishers = interval
                    .map { sleepInterval -> AnyPublisher<[Double], HKError> in
                self.heartRateService.getHeartRate(startDate: sleepInterval.startDate,
                                                   endDate: sleepInterval.endDate)
                    .eraseToAnyPublisher()
            }
            
            return Publishers.Sequence(sequence: publishers)
                .flatMap { $0 }
                .collect()
                .map { values -> Double in
                    print("$$$ \(values)")
                    let result = values.flatMap { $0 }
                    print("$$$ \(result)")
                    return Double(result.reduce(0.0, +))/Double(result.count)
                }
                .eraseToAnyPublisher()
            }.eraseToAnyPublisher()
    }
    
    
//    func getSleepHeartRateAverage(date: Date) -> AnyPublisher<Double, HKError> {
//        let publishers = self.sleepService.getSleepInterval(date: date)
//            .flatMap { intervals in
//                intervals.map {
//                    self.heartRateService.getHeartRate(startDate: $0.startDate,
//                                                       endDate: $0.endDate)
//                }
//            }.eraseToAnyPublisher()
//        
//        Publishers.concatenateMany(publishers)
//            .map {_ in
//                return 13.0
//            }.eraseToAnyPublisher()
//    }
//    
//    Double(value.reduce(0, +)) / Double(value.count)
    
//    private func getCombinePubishers(_ intervals: [HKSleepIntervalModel])
//    -> AnyPublisher<[Double], HKError> {
//        let publishers = intervals.map {
//            self.heartRateService.getHeartRate(startDate: $0.startDate,
//                                               endDate: $0.endDate)
//            .eraseToAnyPublisher()
//        }
//        return Publishers.concatenateMany(publishers).eraseToAnyPublisher()
//    }
}
