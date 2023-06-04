//
//  LifePatternModel.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/05/13.
//

import Foundation

//{
//    "mid": 1,
//    "date": "2024-05-24T15:00:00.000+00:00",
//    "activitySteps" : 80,
//    "sleepDuration" : 40 ,
//    "sleepHrAverage" : 80.9,
//    "sleepRmssd" : 40.8
//}

struct SaveLifePatternRequestModel: Codable {
    /// 유저 mid
    let mid: Int
    /// 생활 정보 출처 날짜
    let date: String
    /// 하루 걸음 수:
    let activitySteps: Int
    /// 총 수면 시간
    let sleepDuration: Int
    /// 수면 시간 중 평균 심박동
    let sleepHrAverage: Double
    /// 수면 중 심박동 변동-변위 [평균]
    let sleepRmssd: Double
}
