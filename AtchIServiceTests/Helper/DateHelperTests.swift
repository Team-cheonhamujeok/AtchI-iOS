//
//  DateHelperTests.swift
//  AtchIServiceTests
//
//  Created by DOYEON LEE on 2023/06/01.
//

@testable import AtchI
import XCTest

final class DateHelperTests: XCTestCase {
    
    var helper: DateHelper!

    override func setUpWithError() throws {
        helper = DateHelper.shared
    }

    override func tearDownWithError() throws {
        helper = nil
    }

    func testConvertStringToDateSuccess() throws {
        // given
        let dateString = "2024-05-26T15:00:00.000+00:00"
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let expected = dateFormatter.date(from: dateString)
        
        // when
        let convertedDate = DateHelper.convertStringToDate(dateString)
        
        // then
        XCTAssertEqual(expected, convertedDate)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
