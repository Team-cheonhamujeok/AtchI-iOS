//
//  MockHKData.swift
//  AtchIServiceTests
//
//  Created by 강민규 on 2023/05/15.
//

import Foundation

import HealthKit

struct MockHKData {
    static var sleepData: [HKCategorySample] = [
        HKCategorySample(type: HKCategoryType(.sleepAnalysis),
                         value: 0,
                         start: Date(),
                         end: Date(),
                         device: nil,
                         metadata: ["HKTimeZone": "Asia/Seoul"])]
    
    static var stepData: HKStatistics? = nil
    static var distanceData: HKStatistics? = nil
    static var energyData: HKStatistics? = nil
    
    static var heartData: [HKCategorySample] = [
        HKCategorySample(type: HKCategoryType(.lowHeartRateEvent),
                         value: 0,
                         start: Date(),
                         end: Date(),
                         device: nil,
                         metadata: ["HKTimeZone": "Asia/Seoul"])]
}
