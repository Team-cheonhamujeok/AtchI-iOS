//
//  HKHeartRateServiceType.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/05/13.
//

import Combine
import Foundation
import HealthKit

protocol HKHeartRateServiceType {
    
    /// 특정 시간 내의 심박동 정보를 가져옵니다.
    ///
    /// - Parameters:
    ///   - startDate: 가져올 기간의 시작 날짜입니다.
    ///   - endDate: 가져올 기간의 끝 날짜입니다.
    func getHeartRate(startDate: Date,
                      endDate: Date)
    -> AnyPublisher<[Double], HKError>
    
    /// 특정 시간 내의 심박동 변이 정보를 가져옵니다.
    /// 
    /// - Parameter date: 대상 날짜입니다.
    func getHeartRateVariability(date: Date) -> Future<[Double], HKError>
}
