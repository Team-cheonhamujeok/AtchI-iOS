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
            sleepService: MKSleepServiceMock(),
            activityService: HKActivityServiceMock(),
            heartRateService: HKHeartRateServiceMock())
            }

    override func tearDownWithError() throws {
        service = nil
    }
    
    func testSaveLifePatternsSuccess() {
        // given
        let today = Date()
        let calendar = Calendar.current
        let todayStart = calendar.startOfDay(for: today)
        let threeDaysAgo = calendar.date(byAdding: .day, value: -3, to: todayStart)! // 마지막 수정일 3일전으로 설정
        let formatter = ISO8601DateFormatter()
        let threeDaysAgoDate = formatter.string(from: threeDaysAgo)
        let lastDate: String? = threeDaysAgoDate
        
        var received: SaveLifePatternResponseModel?
        
        // when
        let _ = service.requestSaveLifePatterns(lastDate: lastDate)
            .sink(receiveCompletion: { _ in },
                  receiveValue: {
                      received = $0
                  })
        
        // then
        let expectedResponse = LifePatternAPIMock.SaveLifePatternMock.lastDateIsToday.response
        let jsonData = expectedResponse.data(using: .utf8) ?? Data()
        let decoder = JSONDecoder()
        do {
            let expected = try decoder.decode(SaveLifePatternResponseModel.self, from: jsonData)
            XCTAssertEqual(expected, received)
        } catch { }
    }
    
    func testSaveLifePatternsLastDayIsToday() {
        // given
        let formatter = ISO8601DateFormatter()
        let date = formatter.string(from: Date())
        let lastDate: String? = date
        var received: LifePatternError?
        
        // when
        let _ = service.requestSaveLifePatterns(lastDate: lastDate)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished: break
                case .failure(let error):
                    received = error
                }
            },receiveValue: { _ in })
        
        // then
        XCTAssertEqual(LifePatternError.saveLifePattern(.lastDateIsToday),
                       received)
    }
    
    func testSaveLifePatternsDoesNotExistLastDate() {
        // given
        var received: SaveLifePatternResponseModel?
        
        // when
        let _ = service.requestSaveLifePatterns(lastDate: nil)
            .sink(receiveCompletion: { _ in },
                  receiveValue: {
                      received = $0
                  })
        
        // then
        let expectedResponse = LifePatternAPIMock.SaveLifePatternMock.lastDateIsToday.response
        let jsonData = expectedResponse.data(using: .utf8) ?? Data()
        let decoder = JSONDecoder()
        do {
            let expected = try decoder.decode(SaveLifePatternResponseModel.self, from: jsonData)
            XCTAssertEqual(expected, received)
        } catch { }
    }
    
    func testLastDateExistsResponse() {
        // given
        let request = LifePatternAPIMock.LastDateMock.exists.request
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
        let request = LifePatternAPIMock.LastDateMock.doesNotExist.request
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

    #if targetEnvironment(simulator)
    #else
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            let expection = XCTestExpectation(description: "measure SaveLifePattern")
            let _ = service.requestSaveLifePatterns(lastDate: nil)
                .sink(receiveCompletion: { _ in },
                      receiveValue: {_ in 
                    expection.fulfill()
                      })
            wait(for: [expection])
        }
    }
    #endif

}
