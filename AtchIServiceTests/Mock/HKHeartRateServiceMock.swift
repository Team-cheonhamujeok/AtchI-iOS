//
//  HKHeartRateServiceMock.swift
//  AtchIServiceTests
//
//  Created by DOYEON LEE on 2023/06/04.
//

@testable import AtchI

import XCTest
import Combine

import Combine
import Foundation

class HKHeartRateServiceMock: HKHeartRateServiceProtocol {
    func getHeartRateAveragePerMin(startDate: Date, endDate: Date) -> AnyPublisher<[Double], HKError> {
        let heartRateData: [Double] = [75, 80, 85]
        
        return Just(heartRateData)
            .setFailureType(to: HKError.self)
            .eraseToAnyPublisher()
    }
    
    func getHeartRateVariability(date: Date) -> Future<[Double], HKError> {
        let variabilityData: [Double] = [0.1, 0.2, 0.3]
        
        return Future<[Double], HKError> { promise in
            promise(.success(variabilityData))
        }
    }
}
