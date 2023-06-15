//
//  HKCategoryValueSleepAnalysis+Extension.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/06/11.
//

import Foundation
import HealthKit

extension HKCategoryValueSleepAnalysis {
    var asSleepType: HKSleepType {
        switch self {
        case .inBed: return .inbed
        case .awake: return .wake
        case .asleepCore: return .core
        case .asleepDeep: return .deep
        case .asleepREM: return .rem
        default: return .undefined
        }
    }
    
    static func asSleepTypeValue(_ value: Int) -> HKSleepType {
        switch value {
        case HKCategoryValueSleepAnalysis.inBed.rawValue:
            return .inbed
        case HKCategoryValueSleepAnalysis.asleepREM.rawValue:
            return .rem
        case HKCategoryValueSleepAnalysis.asleepCore.rawValue:
            return .core
        case HKCategoryValueSleepAnalysis.asleepDeep.rawValue:
            return .deep
        case HKCategoryValueSleepAnalysis.awake.rawValue:
            return .wake
        default:
            return .undefined
        }
    }
}
