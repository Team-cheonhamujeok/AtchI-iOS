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

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.sut = SelfTestViewModel(service: DiagnosisService(provider: MoyaProvider<DiagnosisAPI>()))
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
    }

    func test_자가진단결과리스트_정렬() throws {
        let sample: [SelfTestResult]
        
        
        //print(sut.sortSelfTestResults(results: sample))
    }
    
    func testExample() throws {
        let expectation = XCTestExpectation(description: "Get Data Test Test")
        
        sut.getData()
        
        wait(for: [expectation], timeout: 10.0)
        
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
