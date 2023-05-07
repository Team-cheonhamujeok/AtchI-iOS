//
//  HKHeartRateService.swift
//  AtchI
//
//  Created by 이봄이 on 2023/04/30.
//

import Foundation
import Combine
import HealthKit

class HKHeartRateService {
    let healthKitProvider: HKProvider
    
    init(healthKitProvider: HKProvider) {
        self.healthKitProvider = healthKitProvider
    }
    
    func getHeartRateData() -> Future<[HKQuantitySample], Error> {
        return Future { promise in
            let startDate = self.getYesterdayStartAM(Date())
            let endDate = self.getYesterdayEndPM(Date())
            let predicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: .strictEndDate)
            
            self.healthKitProvider.getQuantityTypeSampleHeart(identifier: .heartRate, predicate: predicate) { count in
                promise(Result.success(count))
            }
        }
    }
    
    func getHeartRateVariability() -> Future<[HKQuantitySample], Error> {
        return Future { promise in
            let startDate = self.getYesterdayStartAM(Date())
            let endDate = self.getYesterdayEndPM(Date())
            let predicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: .strictEndDate)
            
            self.healthKitProvider.getQuantityTypeSampleHeart(identifier: .heartRateVariabilitySDNN, predicate: predicate, completion: { variabilityMS in
                promise(Result.success(variabilityMS))
            })
            
        }
    }
    
    func getRestingHeartRate() -> Future<[HKQuantitySample], Error> {
        return Future { promise in
            let startDate = self.getYesterdayStartAM(Date())
            let endDate = self.getYesterdayEndPM(Date())
            let predicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: .strictEndDate)
            
            self.healthKitProvider.getQuantityTypeSampleHeart(identifier: .restingHeartRate, predicate: predicate, completion: { rate in
                promise(Result.success(rate))
            })
            
        }
    }
    
    
    
    // 어제 시작 시각 (00:00) 구하기
    private func getYesterdayStartAM(_ date: Date) -> Date {
        let calendar = Calendar.current
        
        var components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
        let yesterday = calendar.date(byAdding: .day, value: -2, to: date)!
        components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: yesterday)
        components.hour = 24 // 한국 기준 24:00:00이 시작이므로
        components.minute = 0
        components.second = 0
        let yesterdayStartAM = calendar.date(from: components)!
        
        return yesterdayStartAM
    }
    
    // 어제 끝 시각 (23:59) 구하기
    private func getYesterdayEndPM(_ date: Date) -> Date {
        let calendar = Calendar.current
        
        var components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
        let yesterday = calendar.date(byAdding: .day, value: -1, to: date)!
        components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: yesterday)
        components.hour = 23 // 한국 기준 23:59:59가 마지막이므로
        components.minute = 59
        components.second = 59
        let yesterdayEndPM = calendar.date(from: components)!
        print("어제 끝 시간 : \(yesterdayEndPM)")
        return yesterdayEndPM
    }
    
    
}
