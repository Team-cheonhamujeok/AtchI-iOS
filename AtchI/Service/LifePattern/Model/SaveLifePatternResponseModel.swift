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
/** ```JSON
{
    "mid": 1,
    "lastDate": "2024-05-26T15:00:00.000+00:00",
    "lpCount": 338,
    "predictStart": true,
    "result": "치매 전조증상",
    "resultProba": 0.851975347578765
}
``` */
///
struct SaveLifePatternResponseModel: Codable, Equatable {
    let mid: Int
    let lastDate: String
    let lpCount: Int
    let predictStart: Bool
    let result: String
    let resultProba: Double
}
