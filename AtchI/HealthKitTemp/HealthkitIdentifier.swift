//
//  HealthkitIdentifier.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/04/17.
//

import Foundation
import HealthKit

@available(*, deprecated, message: "더이상 사용하지 않는 열거형입니다.")
enum HealthKitIdentifier {
    // sleep
    case inBedQuentity
    case asleepREMQuentity
    case asleepCoreQuentity
    case asleepDeepQuentity
    case awakeQuentity
    case sleepStartTime
    case sleepEndTime
    
    var hkSleepIdentifier: HKCategoryValueSleepAnalysis? {
        switch self {
        case .inBedQuentity:
            return .inBed
        case .asleepREMQuentity:
            return .asleepREM
        case .asleepCoreQuentity:
            return .asleepCore
        case .asleepDeepQuentity:
            return .asleepDeep
        case .awakeQuentity:
            return .awake
        default:
            return nil
        }
        
    }
    // HKCategoryTypeIdentifier 값에 따른 HealthKitIdentifier 반환
    static func fromHKSleepIdentifier(_ identifier: HKCategoryValueSleepAnalysis) -> HealthKitIdentifier? {
        switch identifier {
        case .inBed:
            return .inBedQuentity
        case .asleepREM:
            return .asleepREMQuentity
        case .asleepCore:
            return .asleepCoreQuentity
        case .asleepDeep:
            return .asleepDeepQuentity
        case .awake:
            return .awakeQuentity
        default:
            return nil
        }
    }
}
