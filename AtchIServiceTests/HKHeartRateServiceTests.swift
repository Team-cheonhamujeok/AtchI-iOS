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
    var sleepService: HKSleepService!
    
    var cancellabe = Set<AnyCancellable>()
    

    override func setUpWithError() throws {
        self.service = HKHeartRateService(healthKitProvider: HKProvider())
        self.dateHelper = DateHelper()
        self.sleepService = HKSleepService(provider: HKProvider(), dateHelper: DateHelper())
    }

    override func tearDownWithError() throws {
        self.service = nil
    }

    func testExample() throws {
        print("####")
        
        let expectation = XCTestExpectation(description: "Sleep HeartRate Test")
        
//        let cancellable = service.getSleepHeartRate(startDate: dateHelper.getYesterdayStartAM(Date()), endDate: dateHelper.getYesterdayEndPM(Date()))
//            .sink(receiveCompletion: { _ in print("### stream 완료") },
//                  receiveValue: { samples in
//                print("받아왔니? \(samples)")
//                expectation.fulfill()
//            })
        
        let cancellable = sleepService.getSleepInterval(date: Date()).sink(receiveCompletion: { _ in print("@@@완료@@@")}, receiveValue: { interval in
//            print("인터벌 내놔\(interval)")
            
            // get heartrate
            let publishers = interval.map {
                self.service.getSleepHeartRate(startDate: $0.startDate,
                                          endDate: $0.endDate)
                .eraseToAnyPublisher()
            }
            
            Publishers.concatenateMany(publishers)
                    .flatMap { $0.publisher }
                    .collect()
                    .sink(receiveCompletion: {_ in}, receiveValue: { value in
                        print("Flattened value: \(value)")
                        
                        expectation.fulfill()
                    }).store(in: &self.cancellabe)

//            combinedPublisher
//                .flatMap { $0.publisher }
//                .collect()
//                .sink { value in
//                    print("Flattened value: \(value)")
//                }
            
            
            
            

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

extension Publishers {
    static func concatenateMany<Output, Failure>(_ publishers: [AnyPublisher<Output, Failure>]) -> AnyPublisher<Output, Failure> {
        return publishers.reduce(Empty().eraseToAnyPublisher()) { acc, elem in
            Publishers.Concatenate(prefix: acc, suffix: elem).eraseToAnyPublisher()
        }
    }
}
