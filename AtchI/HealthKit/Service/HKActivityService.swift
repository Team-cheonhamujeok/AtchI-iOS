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
    func getStepCount(date: Date) -> Future<Double, HKError>
    func getEnergy(date: Date) -> Future<Double, HKError>
    func getDistance(date: Date) -> Future<Double, HKError>
}

class HKActivityService: HKActivityServiceProtocol {
    //MARK: - Properties
    var healthKitProvider: HKProviderProtocol
    
    init(healthkitProvicer: HKProviderProtocol) {
        self.healthKitProvider = healthkitProvicer
    }
    

    //MARK: - Sending Function
    /// - Note: 값을 구하는 기간은 다 똑같으니 predicate는 묶는게 낫겠죠?
    //MARK: 걸음 수
    func getStepCount(date: Date) -> Future<Double, HKError> {
        return Future { promise in
            let startOfDay = self.startDate(date: date)
            let endOfDay = self.endDate(date: date)
            let predicate = HKQuery.predicateForSamples(withStart: startOfDay,
                                                        end: endOfDay,
                                                        options: .strictStartDate)
            
            self.healthKitProvider.getQuantityTypeStatistics(identifier: .stepCount,
                                                         predicate: predicate) { result, err in
                if let err = err {
                    promise(.failure(HKError.providerFetchSamplesFailed(error: err)))
                    return
                }
                guard let sum = result?.sumQuantity() else {
                    promise(.failure(HKError.sumQuentityFailed))
                    return
                }
 
                let value = sum.doubleValue(for: .count())
                promise(Result.success(value))
            }
        }
    }
    
    // MARK: 열량
    func getEnergy(date: Date) -> Future<Double, HKError>  {
        return Future { promise in
            let startOfDay = self.startDate(date: date)
            let endOfDay = self.endDate(date: date)
            let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: endOfDay, options: .strictStartDate)

            self.healthKitProvider.getQuantityTypeStatistics(identifier: .activeEnergyBurned,
                                                         predicate: predicate) { result, err in
                if let err = err {
                    promise(.failure(HKError.providerFetchSamplesFailed(error: err)))
                    return
                }
                guard let sum = result?.sumQuantity() else {
                    promise(.failure(HKError.sumQuentityFailed))
                    return
                }
 
                let value = sum.doubleValue(for: .kilocalorie())
                promise(Result.success(value))
            }
        }
    }
    // MARK: 거리
    func getDistance(date: Date) -> Future<Double, HKError>  {
        return Future { promise in
            let startOfDay = self.startDate(date: date)
            let endOfDay = self.endDate(date: date)
            let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: endOfDay, options: .strictStartDate)
            
            self.healthKitProvider.getQuantityTypeStatistics(identifier: .distanceWalkingRunning,
                                                         predicate: predicate) { result, err in
                if let err = err {
                    promise(.failure(HKError.providerFetchSamplesFailed(error: err)))
                    return
                }
                guard let sum = result?.sumQuantity() else {
                    promise(.failure(HKError.sumQuentityFailed))
                    return
                }
 
                let value = sum.doubleValue(for: .meter())
                promise(Result.success(value))
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
