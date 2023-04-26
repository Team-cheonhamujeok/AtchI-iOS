//
//  HKActivityService.swift
//  AtchI
//
//  Created by 강민규 on 2023/04/24.
//

import Foundation
import Combine
import HealthKit

/// - Note: Protocol이 필요할까요?
protocol HKActivityServiceProtocol {
    var healthKitProvider: HealthKitProvider { get }
    func getStepCount(date: Date) -> Future<Double, Error>
    func getEnergy(date: Date) -> Future<Double, Error>
    func getDistance(date: Date) -> Future<Double, Error>
}

class HKActivityService: HKActivityServiceProtocol {
    //MARK: - Properties
    var healthKitProvider: HealthKitProvider
    
    init(healthkitProvicer: HealthKitProvider) {
        self.healthKitProvider = healthkitProvicer
    }
    

    //MARK: - Sending Function
    /// - Note: 값을 구하는 기간은 다 똑같으니 predicate는 묶는게 낫겠죠?
    //MARK: 걸음 수
    func getStepCount(date: Date) -> Future<Double, Error> {
        return Future { promise in
            let now = Date()
            let startOfDay = Calendar.current.date(byAdding: .day, value: 0, to: now)
            let endOfDay = Calendar.current.date(byAdding: .day, value: 1, to: now)
            let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: endOfDay, options: .strictStartDate)
            
            self.healthKitProvider.getQuantityTypeSample(identifier: .stepCount, predicate: predicate) { count in
                promise(Result.success(count))
            }
        }
    }
    
    // MARK: 열량
    func getEnergy(date: Date) -> Future<Double, Error>  {
        return Future { promise in
            
            let now = Date()
            let startOfDay = Calendar.current.date(byAdding: .day, value: 0, to: now)
            let endOfDay = Calendar.current.date(byAdding: .day, value: 1, to: now)
            let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: endOfDay, options: .strictStartDate)
            
            self.healthKitProvider.getQuantityTypeSample(identifier: .activeEnergyBurned, predicate: predicate) { energy in
                promise(Result.success(energy))
            }
        }
    }
    // MARK: 거리
    func getDistance(date: Date) -> Future<Double, Error>  {
        return Future { promise in
            
            let now = Date()
            let startOfDay = Calendar.current.date(byAdding: .day, value: 0, to: now)
            let endOfDay = Calendar.current.date(byAdding: .day, value: 1, to: now)
            let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: endOfDay, options: .strictStartDate)
            
            self.healthKitProvider.getQuantityTypeSample(identifier: .distanceWalkingRunning, predicate: predicate) { distance in
                promise(Result.success(distance))
            }
        }
    }
}
