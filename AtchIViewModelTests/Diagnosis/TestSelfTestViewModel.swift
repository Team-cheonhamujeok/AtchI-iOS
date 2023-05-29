//
//  TestSelfTestViewModel.swift
//  AtchIViewModelTests
//
//  Created by 강민규 on 2023/05/04.
//

@testable import AtchI
import XCTest

import Moya

final class TestSelfTestViewModel: XCTestCase {
    var sut: SelfTestViewModel!
    let testAnswers: [TestAnswer] = [.little,.little,.little,.little,.little,
                                     .little,.little,.little,.nothing,.nothing,.nothing,.nothing,.nothing,.nothing,.nothing]

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.sut = SelfTestViewModel(service: DiagnosisService(provider: MoyaProvider<DiagnosisAPI>()))
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
    }
    
    func test_이모지_리턴하는_함수() throws {
//        let emoji = sut.getEmoji()
//
//        XCTAssertEqual(emoji, "🙂")
    }
    
    func test_단계_리턴하는_함수() throws {
        
    }
    
    func test_answer에_맞는_Level_리턴하는_함수() throws {
        
    }
    
    func test_문제인덱스_14면_isAgain_변경() throws {
        sut.answers = [.little,.little,.little,.little,.little,
                       .little,.little,.little,.nothing,.nothing,.nothing,.nothing,.nothing,.nothing,.nothing]
        
        (0...14).forEach { _ in
            sut.questionIndex += 1
        }
        
//        XCTAssertTrue(sut.isAgain)
    }
    

    //MARK: - Preformance
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
