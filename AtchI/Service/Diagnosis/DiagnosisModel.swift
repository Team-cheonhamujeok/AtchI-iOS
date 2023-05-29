//
//  DiagnosisModel.swift
//  AtchI
//
//  Created by 강민규 on 2023/05/01.
//

import Foundation

/// mid: Int = 멤버 아이디
/// answerlist: [Int] = 답변 결과 리스트
/// data: String = 검사 결과 시간
struct DiagnosisPostModel: Codable {
    let mid: Int
    let answerlist: [Int]
    let date: String
}

/// did: Int = Diagnosis 아이디
/// mid: Int = 멤버 아이디
/// result: Int = 최종 Point
/// date: Date = 날짜
/// answerlist: [Int] = 답변 결과 리스트
struct DiagnosisGetModel: Codable {
    let did: Int
    let mid: Int
    let result: Int
    let date: String
    let answerlist: [Int]
}
