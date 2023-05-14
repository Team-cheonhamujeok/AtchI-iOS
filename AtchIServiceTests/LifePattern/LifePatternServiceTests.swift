//
//  LifePattern.swift
//  AtchIServiceTests
//
//  Created by DOYEON LEE on 2023/05/14.
//

@testable import AtchI
import Combine
import XCTest

import Moya

/// - Warning:  실제 디바이스 정보를 바탕으로 진행하는 테스트셋입니다. 시뮬레이터에서 실행하지마세요.
final class LifePatternServiceTests: XCTestCase {
    
    var service: LifePatternService!

    override func setUpWithError() throws {
        service = LifePatternService(sleepService: HKSleepService(provider: HKProvider(),
                                                                  dateHelper: DateHelper()),
                                     activityService: HKActivityService(healthkitProvicer: HKProvider()),
                                     heartRateService: HKHeartRateService(healthKitProvider: HKProvider(),
                                                                          dateHelper: DateHelper()))
    }

    override func tearDownWithError() throws {
        service = nil
    }

    func testCreateLifePatternModel() throws {
        let today = Date()
        let calendar = Calendar.current
        let beforeDay = calendar.date(byAdding: .day, value: -1, to: today)!
        print("beforeDay \(beforeDay)")
     
        let expectation = XCTestExpectation(description: "Life Pattern Test")
        let cancellable = service.createLifePatternModel(date: beforeDay)
            .print()
            .sink(receiveCompletion: { _ in},
                  receiveValue: { _ in expectation.fulfill()})
        wait(for: [expectation], timeout: 10.0)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
