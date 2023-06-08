//
//  HKSleepCore.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/06/09.
//

import Foundation


protocol HKSleepCoreProtocol {
    func getSleepInterval(
        input samples: [HKSleepInputEntity]
    ) throws -> [HKSleepIntervalModel]
}

struct HKSleepCore: HKSleepCoreProtocol {
    
    func getSleepInterval(
        input samples: [HKSleepInputEntity]
    ) throws -> [HKSleepIntervalModel] {
        
        let watchSampels = samples
            .filter{ $0.dateSourceProductType.contains("Watch") } // 워치 착용만
            .filter { $0.sleepType == 0 } // inbed만
        if watchSampels.isEmpty {
            throw HKError.watchDataNotFound
        }
        
        return watchSampels
            .map {
                HKSleepIntervalModel(startDate: $0.startDate,
                                        endDate: $0.endDate)
            }
    }
}
