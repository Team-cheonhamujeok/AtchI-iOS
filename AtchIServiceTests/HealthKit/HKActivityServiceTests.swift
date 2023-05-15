//
//  HKActivityServiceTests.swift
//  AtchIServiceTests
//
//  Created by 강민규 on 2023/05/16.
//

@testable import AtchI
import XCTest

import Combine
import HealthKit

final class HKActivityServiceTests: XCTestCase {
    
    let provider: MockHealthKitProvider = MockHealthKitProvider()
    var sut: HKActivityService!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sut = HKActivityService(healthkitProvicer: provider)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
    }

    func test_Example() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
        
        sut.getStepCount(date: Date())
            .sink { err in
                print(err)
            } receiveValue: { double in
                print(double)
            }

    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
