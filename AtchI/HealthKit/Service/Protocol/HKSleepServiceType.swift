//
//  HKSleepServiceType.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/05/04.
//

import Foundation
import Combine

/// HealthKit의 수면 샘플을 가져오는 SleepService의 프로토콜입니다.
///
/// ## Implement
/// ``HKSleepService``
protocol HKSleepServiceType {
    
    /// 진단에 필요한 모든 수면 데이터를 담은 구조체 인스턴스를 반환합니다.
    ///
    /// - Parameter date: 수면 데이터를 추출할 대상 날짜입니다.
    /// - Returns: 수면 데이터를 담은 `HKSleepModel`을 반환합니다
    func getSleepRecord(date: Date, sleepCategory: HKSleepCategory.common) -> Future <HKSleepModel, HKError>
    /// 전체 수면 시간 중 특정 상태인 시간의 총시간(단위: 분)을 구합니다.
    ///
    /// - Note: 어제 오후 6시~ 오늘 오후 6시 사이를 오늘 수면 시간으로 판단합니다.
    ///
    /// - 수면 상태 종류
    ///     - inbed: 애플 워치 미착용시 수면 (총 수면)
    ///     - rem: 렘 수면
    ///     - core: 가벼운 수면
    ///     - deep: 깊은 수면
    ///     - awake: 수면 중 깨어남
    ///
    /// - Parameters:
    ///     - date: 수면 데이터를 추출할 대상 날짜입니다.
    ///     - sleepCategory: 가져오고자 하는 수면 상태 종류입니다.
    /// - Returns: 총 시간을 Int(단위: 분)로 반환합니다.
    func getSleepRecord(date: Date, sleepCategory: HKSleepCategory.origin) -> Future<Int, HKError>
    
    /// 전체 수면 시간 중 특정 상태인 시간의 총시간(단위: 분)을 구합니다.
    ///
    /// - Note: 어제 오후 6시~ 오늘 오후 6시 사이를 오늘 수면 시간으로 판단합니다.
    ///
    /// - 수면 상태 종류
    ///     - total: 총 수면
    ///
    /// - Parameters:
    ///    - date: 수면 데이터를 추출할 대상 날짜입니다.
    ///    - sleepCategory: 가져오고자 하는 수면 상태 종류입니다.
    /// - Returns: 총 시간을 Int(단위: 분)로 반환합니다.
    func getSleepRecord(date: Date, sleepCategory: HKSleepCategory.quentity) -> Future<Int, HKError>
    
    /// 수면 시작 시간또는 종료 시간을 구합니다.
    ///
    /// - Note: 어제 오후 6시~ 오늘 오후 6시 사이를 오늘 수면 시간으로 판단합니다.
    ///
    /// - Parameters:
    ///    - date: 수면 데이터를 추출할 대상 날짜입니다.
    ///    - sleepCategory: 시작 시간 또는 종료 시간을 선택합니다.
    /// - Returns: 수면 시작 시간을 Date형으로 반환합니다.
    func getSleepRecord(date: Date, sleepCategory: HKSleepCategory.date) -> Future<Date, HKError>
}
