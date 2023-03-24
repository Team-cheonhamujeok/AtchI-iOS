//
//  TestQuestion.swift
//  AtchI
//
//  Created by 강민규 on 2023/03/24.
//

import Foundation

/// 자가진단 문제 양식입니다.
///  - Parameters:
///     - index: 문제의 번호입니다 (ex: 첫번째, 두번째, ..)
///     - content : 문제 내용입니다.
///
struct TestQuestion {
    var index: String
    var content: String
}
