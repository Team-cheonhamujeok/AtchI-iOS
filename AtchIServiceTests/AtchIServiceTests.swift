//
//  AtchIServiceTests.swift
//  AtchIServiceTests
//
//  Created by 강민규 on 2023/04/25.
//

@testable import AtchI
import XCTest

import Combine
import HealthKit

/// Real device test. Don't excute on simulator
final class AtchIServiceTests: XCTestCase {

    var service: HKSleepService!

    override func setUpWithError() throws {
        self.service = HKSleepService(hkProvider: HKProvider())
    }

    override func tearDownWithError() throws {
        self.service = nil
    }

    /// receive king
    func testExample() throws {
        
        print("####")
        
        let expectation = XCTestExpectation(description: "Signup Test Test")

        let currentDate = Date() // 현재 날짜와 시간 가져오기
        let threeDaysAgo = Calendar.current.date(byAdding: .day, value: -150, to: currentDate)!
        
        let cancellable = service.fetchSleepSamples(date: threeDaysAgo)
            .sink(receiveCompletion: { _ in print("### stream 완료") },
                  receiveValue: { samples in
                print("### \(samples)")
                expectation.fulfill()
                
            })
        
        wait(for: [expectation], timeout: 5.0)
        
        XCTAssertEqual(0, 0)

    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
