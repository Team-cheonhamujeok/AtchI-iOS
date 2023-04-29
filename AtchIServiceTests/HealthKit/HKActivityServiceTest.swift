//
//  HKActivityServiceTest.swift
//  AtchIServiceTests
//
//  Created by 강민규 on 2023/04/25.
//

@testable import AtchI
import XCTest

import Combine
import HealthKit


/// - Note:
/// - Service만 테스트하면 되나?
/// - Provider는 안해도되나?
///     Provider는 Mock만 만들면 되나? API를 들고오는 부분이니까

final class HKActivityServiceTest: XCTestCase {
    
    var sut: HKActivityService?

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.sut = HKActivityService(healthkitProvicer: MockHealthKitProvider())
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
    }

    func testStep() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
        
        //MARK: Arrange
        let identity: HKQuantityTypeIdentifier = .stepCount
        let now = Date()
        let startOfDay = Calendar.current.date(byAdding: .day, value: 0, to: now)
        let endOfDay = Calendar.current.date(byAdding: .day, value: 1, to: now)
        let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: endOfDay, options: .strictStartDate)
        
        var result = 0.0
        
        //MARK: Act
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        formatter.timeStyle = .full  
        // 1. 지역 설정
        formatter.locale = Locale(identifier: "ko_KR")

        // 2. 시간대 설정
        formatter.timeZone = TimeZone(identifier: "Asia/Seoul")
        
        
        var future = sut?.getStepCount(date: date)
        print("Date:", date)
        print("KRDate:", formatter.string(from: date))
        
        future?.sink(receiveCompletion: { err in
            print(err)
        }, receiveValue: { quantity in
            result = quantity
        })
        
        //MARK: Assert
        XCTAssertEqual(result, 8000)
    }
    
    func testEnergy() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
        
        //MARK: Arrange
        let identity: HKQuantityTypeIdentifier = .stepCount
        let now = Date()
        let startOfDay = Calendar.current.date(byAdding: .day, value: 0, to: now)
        let endOfDay = Calendar.current.date(byAdding: .day, value: 1, to: now)
        let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: endOfDay, options: .strictStartDate)
        
        var result = 0.0
        
        //MARK: Act
        let date = Date()
        var future = sut?.getEnergy(date: date)
        
        future?.sink(receiveCompletion: { err in
            print(err)
        }, receiveValue: { quantity in
            result = quantity
        })
        
        //MARK: Assert
        XCTAssertEqual(result, 0)
    }
    
    func testDistance() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
        
        //MARK: Arrange
        let identity: HKQuantityTypeIdentifier = .stepCount
        let now = Date()
        let startOfDay = Calendar.current.date(byAdding: .day, value: 0, to: now)
        let endOfDay = Calendar.current.date(byAdding: .day, value: 1, to: now)
        let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: endOfDay, options: .strictStartDate)
        
        var result = 0.0
        
        //MARK: Act
        let date = Date()
        var future = sut?.getDistance(date: date)
        
        future?.sink(receiveCompletion: { err in
            print(err)
        }, receiveValue: { quantity in
            result = quantity
        })
        
        //MARK: Assert
        XCTAssertEqual(result, 0)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
