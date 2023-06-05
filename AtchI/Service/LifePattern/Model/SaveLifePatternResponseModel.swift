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
     "lastDate": "2024-09-26T15:00:00.000+00:00",
     "lpCount": 366,
     "predictStart": true,
     "resultProba": [
         0.8397475935423167,
         0.8523449559810172,
         0.30790743760748135
     ]
 }
``` */
///
struct SaveLifePatternResponseModel: Codable, Equatable {
    let mid: Int
    let lastDate: String
    let lpCount: Int
    let predictStart: Bool
    let result: String?
    let resultProba: [Double]
}
