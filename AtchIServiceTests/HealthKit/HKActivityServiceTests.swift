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
    var disposeBag = Set<AnyCancellable>()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sut = HKActivityService(healthkitProvicer: provider)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
    }

    func test_Example() throws {
        let expectation = XCTestExpectation(description: "Signup Test Test")
        
        var result = 0.0
  
        let cancellable = sut?.getStepCount(date: Date())
            .handleEvents(receiveSubscription: { _ in
              print("#start")
            }, receiveOutput: { _ in
              print("#received")
            }, receiveCancel: {
              print("#cancelled")
            })
            .sink(receiveCompletion: { err in
                print("#",err)
            }, receiveValue: { quantity in
                result = quantity
                expectation.fulfill()
            })
            .store(in: &disposeBag)
                
        
        wait(for: [expectation], timeout: 10.0)
        
        //MARK: Assert
        XCTAssertEqual(result, 8000)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
