//
//  WatchInfo.swift
//  AtchI
//
//  Created by 강민규 on 2023/03/23.
//

import Foundation

/// AppleWatch에서 수집할 수 있는 데이터 입니다.
///
/// - Parameters:
///     - walk : 걸음 수
///     - heart : 심장 박동
///     - Sleep : 수면 시간
///     - kcal : 소모 열량
///     - distance : 움직인 거리
///
struct WatchInfo {
    var walk: Int
    var heart: Int
    var sleep: Date
    var kcal: Int
    var distance: Double
}
