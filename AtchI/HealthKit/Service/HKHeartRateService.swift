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
    let heartRateQuantity = HKUnit(from: "count/min")
    
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
    
    func getSleepHeartRate(startDate: Date, endDate: Date) -> Future<[Double], Error> {
        return Future { promise in
            _ = self.fetchHeartRate(startDate: startDate, endDate: endDate).sink(
                receiveCompletion: { completion in
                    switch completion {
                    case .finished: break
                    case .failure(let error):
                        promise(Result.failure(error))
                    }
                }, receiveValue: { [weak self] samples in
                    
                    guard let self = self else { return }
                    
                    let hrData = getHeartRateBPM(samples: samples)
                    
                    promise(Result.success(hrData))
                })
        }
    }
    
    
    
    
    // 어제 시작 시각 (00:00) 구하기
    func getYesterdayStartAM(_ date: Date) -> Date {
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
    func getYesterdayEndPM(_ date: Date) -> Date {
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
    
    private func fetchHeartRate(startDate: Date, endDate: Date) -> Future<[HKQuantitySample], Error> {
        return Future { promise in
            let predicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: .strictEndDate)
            
            self.healthKitProvider.getQuantityTypeSampleHeart(identifier: .heartRate, predicate: predicate) { samples in
                promise(Result.success(samples))
            }
        }
    }
    
    private func getHeartRateBPM(samples: [HKQuantitySample]) -> [Double] {
        let quantitySamples = samples.compactMap { $0 as? HKQuantitySample }
//                print("첫번째 값 : \(quantitySamples[0].quantity.doubleValue(for: heartRateQuantity))")
//                print("마지막 값 : \(quantitySamples.count-1)번째임 \(quantitySamples[quantitySamples.count-1].quantity.doubleValue(for: heartRateQuantity))")
        var totalArray: [Double] = []
        var minuteArray: [Double] = []
        
        for idx in 0..<quantitySamples.count {
            print("\(idx) 번째~~")
            let dateComponent = Calendar.current.dateComponents([.hour, .minute], from: quantitySamples[idx].startDate)
            let heartRate = round(quantitySamples[idx].quantity.doubleValue(for: self.heartRateQuantity))
            
            for hour in 0...23 {
                if idx == 0 {
                    minuteArray.append(heartRate)
                } else {
                    let beforeDatecomponent = Calendar.current.dateComponents([.hour, .minute], from: quantitySamples[idx-1].startDate)
                    if dateComponent.hour == hour {
                        if beforeDatecomponent.minute == dateComponent.minute {
                            minuteArray.append(heartRate)
                        } else if dateComponent.minute != beforeDatecomponent.minute {
                            if minuteArray.isEmpty != true {
                                let minuteAver = Double(minuteArray.reduce(0,+))/Double(minuteArray.count)
                                totalArray.append(minuteAver)
                                minuteArray.removeAll()
                            }
                            minuteArray.append(heartRate)
//                                    print("시간 배열 \(hourArray)")
                            if idx == quantitySamples.count-1 && minuteArray.isEmpty != true {
                                let minuteAver = Double(minuteArray.reduce(0,+))/Double(minuteArray.count)
                                totalArray.append(minuteAver)
                                minuteArray.removeAll()
                            }
                        }
                    } else {
                        continue
                    }
                }
            }
            
        }
        return totalArray
    }
    
}
