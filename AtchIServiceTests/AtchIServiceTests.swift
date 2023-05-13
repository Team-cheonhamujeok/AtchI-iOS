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
    var sleepService: HKSleepService!
    var heartRateService: HKHeartRateService!

    var cancellables = Set<AnyCancellable>()
    

    override func setUpWithError() throws {
        service = LifePatternService(sleepService: HKSleepService(provider: HKProvider(),
                                                                  dateHelper: DateHelper()),
                                     activityService: HKActivityService(healthkitProvicer: HKProvider()),
                                     heartRateService: HKHeartRateService(healthKitProvider: HKProvider()))
        self.sleepService = HKSleepService(provider: HKProvider(),
                                           dateHelper: DateHelper())
        self.heartRateService = HKHeartRateService(healthKitProvider: HKProvider())
    }

    override func tearDownWithError() throws {
    }

    func testExample() throws {
        let today = Date()
        let calendar = Calendar.current
        let beforeDay = calendar.date(byAdding: .day, value: -3, to: today)!
     
        let expectation = XCTestExpectation(description: "Life Pattern Test")
        let cancellable = service
            .processInput(date: beforeDay)
            .print()
            .sink(receiveCompletion: { _ in},
                  receiveValue: { _ in expectation.fulfill()})
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testExample2() throws {
        print("####")
        
        let expectation = XCTestExpectation(description: "Sleep HeartRate Test")
        
        let today = Date()
        let calendar = Calendar.current
        let beforeDay = calendar.date(byAdding: .day, value: -3, to: today)!
     
        let cancellable = self.sleepService.getSleepInterval(date: beforeDay)
            .sink(receiveCompletion: { _ in print("@@@완료@@@")},
                  receiveValue: { interval in
                print(interval)
            // get heartrate
            let publishers = interval.map {
                self.heartRateService.getHeartRate(startDate: $0.startDate,
                                          endDate: $0.endDate)
                .eraseToAnyPublisher()
            }
            
                
            Publishers.concatenateMany(publishers)
                    .flatMap { $0.publisher }
                    .collect()
                    .print()
                    .sink(receiveCompletion: { completion in
                        switch completion {
                        case .finished: break
                        case .failure(let error):
                            print("error \(error.localizedDescription)")
                        }
                    }, receiveValue: { value in
                        print("Flattened value: \(value)")
                        let average = Double(value.reduce(0, +))/Double(value.count)
                        print(average)
                        expectation.fulfill()
                    }).store(in: &self.cancellables)
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
