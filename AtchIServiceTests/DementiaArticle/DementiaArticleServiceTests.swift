//
//  DementiaArticleServiceTests.swift
//  AtchIServiceTests
//
//  Created by DOYEON LEE on 2023/06/01.
//

@testable import AtchI
import XCTest

final class DementiaArticleServiceTests: XCTestCase {
    
    var service: DementiaArticleService!

    override func setUpWithError() throws {
        service = DementiaArticleService()
    }

    override func tearDownWithError() throws {
        service = nil
    }

    /// - Warning: 동작 확인용 테스트 코드입니다.
    func test() throws {
        print(service.getDementiaArticles())
    }

    func testPerformance() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
            service.getDementiaArticles()
        }
    }

}
