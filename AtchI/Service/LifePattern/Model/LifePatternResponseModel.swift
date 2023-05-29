//
//  LifePatternResponseModel.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/05/25.
//

import Foundation

/// 생활패턴 api 응답 형식입니다.
///
/// - Response 예시
///```JSON
///{
///    "mid": 1, //int
///    "lastDate": "2024-05-26T15:00:00.000+00:00", //Date
///    "lpCount": 30, //int
///    "predictStart": false //Boolean
///}```
///
struct LifePatternResponseModel: Codable {
    let mid: Int
    let lastDate: Date
    let lpCount: Int
    let predictStart: Bool
}
