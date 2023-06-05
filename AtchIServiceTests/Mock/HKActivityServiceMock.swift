//
//  HKActivityServiceMock.swift
//  AtchIServiceTests
//
//  Created by DOYEON LEE on 2023/06/03.
//

@testable import AtchI

import XCTest
import Combine

class HKActivityServiceMock: HKActivityServiceProtocol {
    
    func getStepCount(date: Date) -> Future<Double, AtchI.HKError> {
        return Future { promise in
            promise(.success(3000))
        }
    }
    
    func getEnergy(date: Date) -> Future<Double, AtchI.HKError> {
        return Future { promise in
            promise(.success(2000))
        }
    }
    
    func getDistance(date: Date) -> Future<Double, AtchI.HKError> {
        return Future { promise in
            promise(.success(300))
        }
    }
    
}
