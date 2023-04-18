//
//  HealthKitDateModel.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/04/17.
//

import Foundation

@available(*, deprecated, message: "더이상 사용하지 않는 모델입니다.")
struct HealthKitDateModel: HealthKitModelType {
    let identifier: HealthKitIdentifier
    let date: Date?
}
