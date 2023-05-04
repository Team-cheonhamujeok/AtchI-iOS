//
//  HKSleepIndividualType.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/05/04.
//

import Foundation
import Combine

protocol HKSleepIndividualServiceType {
    
    /// 전체 수면 시간 중 특정 상태인 시간의 총시간(단위: 분)을 구합니다.
    ///
    /// - 수면 상태 종류
    /// ```swift
    /// enum HKSleepCategory {
    ///    case total // 애플 워치 착용 여부와 관련 없이 전체 수면 시간
    ///    case inbed // 애플 워치 미 착용시 수면 종류
    ///    case rem // 렘 수면
    ///    case core // 가벼운 수면
    ///    case deep // 깊은 수면
    ///    case awake // 수면중 깨어남
    /// }
    ///  ```
    ///
    /// - Parameters:
    ///     - date: 가져오고자 하는 대상 날짜입니다.
    ///     - sleepCategory: 가져오고자 하는 수면 상태 종류입니다.
    /// - Returns: 총 시간을 Int(단위: 분)로 반환합니다.
    func getSleepQuentity(date: Date, sleepCategory: HKSleepService.HKSleepCategory) -> Future<Int, Never>
}
