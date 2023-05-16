//
//  HKHeartRateServiceTests.swift
//  AtchIServiceTests
//
//  Created by 이봄이 on 2023/05/01.
//

@testable import AtchI
import XCTest

import Combine
import HealthKit

final class HKHeartRateServiceTests: XCTestCase {

    var service: HKHeartRateService!
    var dateHelper: DateHelper!
    
//    var cancellabe = Set<AnyCancellable>()
    

    override func setUpWithError() throws {
        self.service = HKHeartRateService(healthKitProvider: HKProvider(), dateHelper: DateHelper())
        self.dateHelper = DateHelper()
    }

    override func tearDownWithError() throws {
        self.service = nil
    }

    func testExample() throws {
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
