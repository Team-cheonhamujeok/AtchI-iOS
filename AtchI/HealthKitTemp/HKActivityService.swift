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
    var healthKitProvider: HealthKitProviderProtocol { get }
    func getStepCount(date: Date) -> Future<Double, Error>
    func getEnergy(date: Date) -> Future<Double, Error>
    func getDistance(date: Date) -> Future<Double, Error>
}

class HKActivityService: HKActivityServiceProtocol {
    //MARK: - Properties
    var healthKitProvider: HealthKitProviderProtocol
    
    init(healthkitProvicer: HealthKitProviderProtocol) {
        self.healthKitProvider = healthkitProvicer
    }
    

    //MARK: - Sending Function
    /// - Note: 값을 구하는 기간은 다 똑같으니 predicate는 묶는게 낫겠죠?
    //MARK: 걸음 수
    func getStepCount(date: Date) -> Future<Double, Error> {
        return Future { promise in
            let startOfDay = self.startDate(date: date)
            let endOfDay = self.endDate(date: date)
            let predicate = HKQuery.predicateForSamples(withStart: startOfDay,
                                                        end: endOfDay,
                                                        options: .strictStartDate)
            
            self.healthKitProvider.getQuantityTypeSample(identifier: .stepCount,
                                                         predicate: predicate) { count in
                promise(Result.success(count))
            }
        }
    }
    
    // MARK: 열량
    func getEnergy(date: Date) -> Future<Double, Error>  {
        return Future { promise in
            let startOfDay = self.startDate(date: date)
            let endOfDay = self.endDate(date: date)
            let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: endOfDay, options: .strictStartDate)
            
            self.healthKitProvider.getQuantityTypeSample(identifier: .activeEnergyBurned, predicate: predicate) { energy in
                promise(Result.success(energy))
            }
        }
    }
    // MARK: 거리
    func getDistance(date: Date) -> Future<Double, Error>  {
        return Future { promise in
            let startOfDay = self.startDate(date: date)
            let endOfDay = self.endDate(date: date)
            let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: endOfDay, options: .strictStartDate)
            
            self.healthKitProvider.getQuantityTypeSample(identifier: .distanceWalkingRunning, predicate: predicate) { distance in
                promise(Result.success(distance))
            }
        }
    }
    // MARK: - Private Func
    private func startDate(date: Date) -> Date? {
        let calendar = Calendar.current
        var components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
        components.hour = 0
        components.minute = 0
        components.second = 0
        
        let start = calendar.date(from: components)!
        
        return start
    }
    
    private func endDate(date: Date) -> Date? {
        let calendar = Calendar.current
        var components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
        components.hour = 23
        components.minute = 59
        components.second = 59
        
        let end = calendar.date(from: components)!
        
        return end
    }
}
