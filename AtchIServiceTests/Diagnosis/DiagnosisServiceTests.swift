//
//  DiagnosisServiceTests.swift
//  AtchIServiceTests
//
//  Created by 강민규 on 2023/05/01.
//
@testable import AtchI
import XCTest

final class DiagnosisServiceTests: XCTestCase {
    
    var sut: DiagnosisServiceType?

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.sut = DiagnosisService()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        self.sut = nil
    }

    func testExample() throws {
        
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
