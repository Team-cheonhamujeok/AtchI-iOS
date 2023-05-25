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


final class AtchIServiceTests: XCTestCase {
    
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
    
    func testExample() throws {
        
        let expectation = XCTestExpectation(description: "LifePatternTest")
        
        // 현재 날짜 가져오기
        let currentDate = Date()
        
        // Calendar와 DateComponents를 사용하여 100일 전(임시)의 날짜 계산
        let lifePatternPublishers = (0...0).reversed()
            .compactMap { subtractDay -> AnyPublisher<LifePatternModel, Never>? in
                var dateComponents = DateComponents()
                dateComponents.day = -subtractDay
                let calendar = Calendar.current
                guard let calculatedDate = calendar.date(byAdding: dateComponents, to: currentDate)
                else { return nil }
                
                return service.createLifePatternModel(date: calculatedDate)
            }
        
        let cancellable = lifePatternPublishers[0]
            .collect()
            .sink {
                expectation.fulfill()
                print( $0 )
            }
        
        wait(for: [expectation], timeout: 20.0)
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
