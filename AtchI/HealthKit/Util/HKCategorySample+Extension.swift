//
//  HKCategorySample+Extension.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/06/11.
//

import Foundation
import HealthKit

extension HKCategorySample {
    var mappedProductType: HKProductType {
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
    
    var mappedSleepEntity: HKSleepEntity {
            return HKSleepEntity(
                startDate: self.startDate,
                endDate: self.endDate,
                sleepType: HKCategoryValueSleepAnalysis
                    .mapSleepTypeValue(self.value),
                dateSourceProductType: self.mappedProductType
            )
    }
}
