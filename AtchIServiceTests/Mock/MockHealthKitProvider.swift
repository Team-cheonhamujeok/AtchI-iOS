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
    
    func getQuantityTypeSample(identifier: HKQuantityTypeIdentifier,
                               predicate: NSPredicate,
                               completion: @escaping ((Double) -> Void)) {
        
        // Identifier로 Type 분류
        guard let quantityType = HKQuantityType.quantityType(forIdentifier: identifier) else {
            print("'HealthKitProvider': 올바르지 않은 ID입니다.")
            return
        }
      
        switch identifier {
        case .stepCount:
            completion(8000.0)
        case .activeEnergyBurned:
            completion(200.0)
        case .distanceWalkingRunning:
            completion(200.0)
        default:
            fatalError("Unexpected identifier \(identifier)")
        }
    }
}
