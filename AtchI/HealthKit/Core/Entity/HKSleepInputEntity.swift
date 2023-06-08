//
//  HKSleepInputEntity.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/06/09.
//

import Foundation

struct HKSleepInputEntity {
    let startDate: Date
    let endDate: Date
    let sleepType: Int
    let dateSourceProductType: String
    
    var sleepTypeDescription: String {
        switch self.sleepType {
        case 0: return "inBed"
        case 2: return "awake"
        case 3: return "asleepCore"
        case 4: return "asleepDeep"
        case 5: return "asleepREM"
        default: return "undifined"
        }
    }
}
