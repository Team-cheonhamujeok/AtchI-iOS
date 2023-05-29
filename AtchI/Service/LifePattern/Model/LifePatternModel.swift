//
//  LifePatternModel.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/05/13.
//

import Foundation

struct LifePatternModel: Codable {
    /// 유저 mid
    let mid: Int
    /// 생활 정보 출처 날짜
    let date: Date
    /// 하루 걸음 수:
    let activity_steps: Int
    /// 총 수면 시간
    let sleep_duration: Int
    /// 수면 시간 중 평균 심박동
    let sleep_hr_average: Double
    /// 수면 중 심박동 변동-변위 [평균]
    let sleep_rmssd: [Double]
}
