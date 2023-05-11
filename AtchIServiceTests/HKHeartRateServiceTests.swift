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
    

    override func setUpWithError() throws {
        self.service = HKHeartRateService(healthKitProvider: HKProvider())
    }

    override func tearDownWithError() throws {
        self.service = nil
    }

    func testExample() throws {
        print("####")
        
        let expectation = XCTestExpectation(description: "Signup Test Test")

        let cancellable = service.getSleepHeartRate(startDate: service.getYesterdayStartAM(Date()), endDate: service.getYesterdayEndPM(Date()))
            .sink(receiveCompletion: { _ in print("### stream 완료") },
                  receiveValue: { samples in
                print("받아왔니? \(samples)")
                expectation.fulfill()
                
            })
        
        wait(for: [expectation], timeout: 100.0)
        
        XCTAssertEqual(0, 0)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
