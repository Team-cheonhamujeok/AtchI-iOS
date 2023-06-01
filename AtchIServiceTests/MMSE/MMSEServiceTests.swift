//
//  MMSEServiceTests.swift
//  AtchIServiceTests
//
//  Created by DOYEON LEE on 2023/06/01.
//

@testable import AtchI
import Combine
import XCTest

import Moya

final class MMSEServiceTests: XCTestCase {
    
    var service: MMSEService!

    override func setUpWithError() throws {
        service = MMSEService(provider: MoyaProvider<MMSEAPI>())
    }

    override func tearDownWithError() throws {
        service = nil
    }
    
    /// MMSE 결과 점수 게산
    func testMMSEResultScores() throws {
        // given
        let questions = service.getMMSEQuestions()
        
        let correctAnswers: [MMSEQuestionModel: String] = questions
            .reduce(into: [:]) { dict, item in
            dict[item] = "1"
        }
        
        let expectAnswers: [String: String] =
        [MMSEResultType.timePerception.description : "4/4",
         MMSEResultType.attentionCalculation.description : "5/5",
         MMSEResultType.language.description: "2/2",
         MMSEResultType.memoryEncodingRecall.description: "3/3",
         MMSEResultType.spatialPerception.description: "2/2"]
        
        // when
        let results = service.getMMSEResultScores(correctAnswers)
        

        // then
        XCTAssertEqual(expectAnswers, results)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
