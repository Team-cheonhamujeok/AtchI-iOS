//
//  MockHealthKitProvider.swift
//  AtchIServiceTests
//
//  Created by 강민규 on 2023/04/26.
//

@testable import AtchI

import Combine
import HealthKit

class MockHealthKitProvider: HKProviderProtocol {
    
    var cancellables = Set<AnyCancellable>()
    
    func getQuantityTypeStatisticsSamples(
        identifier: HKQuantityTypeIdentifier,
        predicate: NSPredicate,
        completion: @escaping ((Double, AtchI.HKError?) -> Void)) {
        
        // Identifier로 Type 분류
        guard let quantityType = HKQuantityType.quantityType(forIdentifier: identifier) else {
            print("'HealthKitProvider': 올바르지 않은 ID입니다.")
            return
        }
      
        switch identifier {
        case .stepCount:
            completion(8000.0, nil)
        case .activeEnergyBurned:
            completion(200.0, nil)
        case .distanceWalkingRunning:
            completion(200.0, nil)
        default:
            fatalError("Unexpected identifier \(identifier)")
        }
    }
    
    func getCategoryTypeSamples(
        identifier: HKCategoryTypeIdentifier,
        predicate: NSPredicate,
        completion: @escaping ([HKCategorySample], AtchI.HKError?)
        -> Void) {
        
    }
}
