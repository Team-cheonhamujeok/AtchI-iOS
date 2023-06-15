//
//  HKQuentitySample+Extension.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/06/11.
//

import Foundation
import HealthKit

extension HKQuantitySample {
    var asHeartRateEntity: HKHeartRateEntity {
        HKHeartRateEntity(
            startDate: self.startDate,
            endDate: self.endDate,
            quantity: self.quantity.doubleValue(
                for: HKUnit(from: "count/min")
            )
        )
    }
}

