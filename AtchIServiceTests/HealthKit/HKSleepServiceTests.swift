//
//  HKSleepServiceTests.swift
//  AtchIServiceTests
//
//  Created by DOYEON LEE on 2023/05/11.
//

@testable import AtchI
import XCTest
import Combine
import HealthKit

#if targetEnvironment(simulator)
#else
final class HKSleepServiceTests: XCTestCase {
    
    var service: HKSleepService!

    override func setUpWithError() throws {
        self.service = HKSleepService(provider: HKProvider(), dateHelper: DateHelper())
    }

    override func tearDownWithError() throws {
    }

    func testExample() throws {

        let expectation = XCTestExpectation(description: "Signup Test Test")

        let cancellable = service.getSleepInterval(date: Date())
            .sink(receiveCompletion: { _ in },
                  receiveValue: { result in
                print("\(result)")
                expectation.fulfill()
                
            })
        
        wait(for: [expectation], timeout: 10.0)
        
        XCTAssertEqual(0, 0)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
#endif
