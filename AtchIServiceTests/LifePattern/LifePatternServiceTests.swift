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

final class LifePatternServiceTests: XCTestCase {
    
    var service: LifePatternService!

    override func setUpWithError() throws {
        service = LifePatternService(
            provider: MoyaProvider<LifePatternAPI>(stubClosure: MoyaProvider.immediatelyStub),
            sleepService: HKSleepService(provider: HKProvider(),
                                         dateHelper: DateHelper()),
            activityService: HKActivityService(healthkitProvicer: HKProvider()),
            heartRateService: HKHeartRateService(healthKitProvider: HKProvider(),
                                                 dateHelper: DateHelper()))
    }

    override func tearDownWithError() throws {
        service = nil
    }
    
    func testLastDateExistsResponse() {
        // given
        let request = LifePatternAPIMock.lastDate(.exists).request
        var received: String?
        
        // when
        let cancellable = service.requestLastDate(mid: request)
            .sink(receiveCompletion: { _ in },
                  receiveValue: { response in
                received = response.response.lastDate ?? ""
            })
        
        // then
        XCTAssertEqual("2024-05-26T15:00:00.000+00:00", received)
    }
    
    func testLastDateDoesNotExistResponse() {
        // given
        let request = LifePatternAPIMock.lastDate(.doesNotExist).request
        var received: String?
        
        // when
        let cancellable = service.requestLastDate(mid: request)
            .sink(receiveCompletion: { _ in },
                  receiveValue: { response in
                received = response.response.lastDate ?? ""
            })
        
        // then
        XCTAssertEqual("", received)
    }

    /// 실제 값 테스트입니다. 시뮬레이터에서 실행하지 마세요.
    func testCreateLifePatternModel() throws {
//        let today = Date()
//        let calendar = Calendar.current
//        let beforeDay = calendar.date(byAdding: .day, value: -2, to: today)!
//        print("beforeDay \(beforeDay)")
//
//        let expectation = XCTestExpectation(description: "Life Pattern Test")
//        let cancellable = service.createLifePatternModel(date: beforeDay)
//            .print()
//            .sink(receiveCompletion: { _ in},
//                  receiveValue: { _ in expectation.fulfill()})
//        wait(for: [expectation], timeout: 10.0)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
