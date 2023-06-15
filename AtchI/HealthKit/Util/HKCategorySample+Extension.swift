//
//  HKCategorySample+Extension.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/06/11.
//

import Foundation
import HealthKit

extension HKCategorySample {
    var asProductType: HKProductType {
        if ((self
            .sourceRevision
            .productType?
            .contains("Watch")) != nil)
        {
            return .watch
        } else if ((self
            .sourceRevision
            .productType?
            .contains("iPhone")) != nil)
        {
            return .iPhone
        } else {
            return .other
        }
    }
    
    var asSleepEntity: HKSleepEntity {
            return HKSleepEntity(
                startDate: self.startDate,
                endDate: self.endDate,
                sleepType: HKCategoryValueSleepAnalysis
                    .asSleepTypeValue(self.value),
                dateSourceProductType: self.asProductType
            )
    }
}
