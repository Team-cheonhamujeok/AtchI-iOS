//
//  XCTestCaseExtension.swift
//  AtchIViewModelTests
//
//  Created by DOYEON LEE on 2023/04/15.
//

import Foundation
import XCTest
import Combine

extension XCTestCase {
    
    /// https://betterprogramming.pub/testing-your-combine-publishers-8ccd6bd151b
    typealias CompetionResult = (expectation: XCTestExpectation,
                                 cancellable: AnyCancellable)
    
    func expectValue<T: Publisher>(of publisher: T,
                                   timeout: TimeInterval = 2,
                                   file: StaticString = #file,
                                   line: UInt = #line,
                                   equals: [T.Output]) -> CompetionResult where T.Output: Equatable {
        let exp = expectation(description: "Correct values of " + String(describing: publisher))
        var mutableEquals = equals
        let cancellable = publisher
            .dropFirst()
            .sink(receiveCompletion: { _ in },
                  receiveValue: { value in
                if value == mutableEquals.first {
                    mutableEquals.remove(at: 0)
                    if mutableEquals.isEmpty {
                        exp.fulfill()
                    }
                }
                else {
                    // 틀릴 시 로그 찍기
                    XCTContext.runActivity(named: "Receive Value") { _ in
                        print("Case: \(equals.count - mutableEquals.count) Value: \(value) Expect: \(mutableEquals.first)")
                    }
                }
            })
        // 내 코드
        //        var count = 0
        //        let cancellable = publisher
        //                .dropFirst()
        //                .sink(receiveCompletion: { _ in },
        //                     receiveValue: { value in
        //                    // 몇 번째 방출인지 로그로 출력
        //                    XCTContext.runActivity(named: "Receive Value") { _ in
        //                        print("Value count: \(count + 1) Value: \(value) Expect: \(equals[count])")
        //                    }
        //                    XCTAssertTrue(value == equals[count])
        //                    // 몇번째 방출인지
        //                    count += 1
        //                  })
        
        return (exp, cancellable)
    }
}
