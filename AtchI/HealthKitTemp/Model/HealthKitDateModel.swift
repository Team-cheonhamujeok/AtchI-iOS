//
//  HealthKitDateModel.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/04/17.
//

import Foundation

struct HealthKitDateModel: HealthKitModelType {
    let identifier: HealthKitIdentifier
    let time: Date?
}
