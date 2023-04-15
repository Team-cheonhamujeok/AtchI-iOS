//
//  HealthKitService.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/04/16.
//

import Foundation
import HealthKit

class HealthKitService {
    
    let healthKitProvicer: HealthKitProvicer
    
    let calendar = Calendar.current
    
    // state
    var inBedTime: Int? = nil
    var asleepRemTime: Int? = nil
    var asleepCoreTime: Int? = nil
    var asleepDeepTime: Int? = nil
    var awakeTime: Int? = nil
    
    
    init(healthkitProvicer: HealthKitProvicer) {
        self.healthKitProvicer = healthkitProvicer
    }
    
    func start(){
        // 오늘 날짜 정의
        let endDate = Date() // 현재 시간
        let startDate = calendar.date(byAdding: .day, value: -1, to: endDate) // 1일 전 시간
        
        self.getSleepData(startDate: startDate!, endDate: endDate) { samples in
            // 수면 총량 구하기
            self.inBedTime = self.getSleepTimeQuentity(sleepType: HKCategoryValueSleepAnalysis.inBed,
                                  samples: samples)
            self.asleepRemTime = self.getSleepTimeQuentity(sleepType: HKCategoryValueSleepAnalysis.asleepREM,
                                  samples: samples)
            self.asleepCoreTime = self.getSleepTimeQuentity(sleepType: HKCategoryValueSleepAnalysis.asleepCore,
                                  samples: samples)
            self.asleepDeepTime = self.getSleepTimeQuentity(sleepType: HKCategoryValueSleepAnalysis.asleepDeep,
                                  samples: samples)
            self.awakeTime = self.getSleepTimeQuentity(sleepType: HKCategoryValueSleepAnalysis.awake,
                                  samples: samples)
        }
    }
    
    func getSleepTimeQuentity(sleepType: HKCategoryValueSleepAnalysis,
                          samples: [HKCategorySample]) -> Int {
        let sum = samples.filter{ $0.value == sleepType.rawValue }
            .reduce(into: 0) { (result, sample) in
            let minutes = calendar.dateComponents([.minute], from: sample.startDate, to: sample.endDate).minute ?? 0
            result += minutes
        }
        return sum
    }
    
    func getSleepData(startDate: Date, endDate: Date, callback: @escaping ([HKCategorySample]) -> Void){
        
        // 조건 정의
        let calendar = Calendar.current
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate)
        
        //
        healthKitProvicer.getCategoryTypeSample(identifier: .sleepAnalysis,
                                                predicate: predicate) { samples in
            print(samples)
            callback(samples)
        }
    }
}
