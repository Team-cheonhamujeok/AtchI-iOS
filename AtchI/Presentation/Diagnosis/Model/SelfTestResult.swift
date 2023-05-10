//
//  SelfTestResult.swift
//  AtchI
//
//  Created by 강민규 on 2023/03/21.
//

import Foundation

/// 자가 진단을 하고 나서 나온 결과 Model 입니다.
///
/// - Parameters:
///     - id : 자가진단 결과의 고유 ID
///     - date : 자가진단 날짜
///     - point : 자가진단 점수
///     - level : 치매 단계
///
struct SelfTestResult: Identifiable {
    var id: Int
    var mid: Int
    var date: String
    var point: Int
    var level: String
}
