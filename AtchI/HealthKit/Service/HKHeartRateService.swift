//
//  HKHeartRateService.swift
//  AtchI
//
//  Created by 이봄이 on 2023/04/30.
//

import Foundation
import Combine
import HealthKit

class HKHeartRateService: HKHeartRateServiceType {
    let healthKitProvider: HKProvider
    let heartRateQuantity = HKUnit(from: "count/min")
    
    init(healthKitProvider: HKProvider) {
        self.healthKitProvider = healthKitProvider
    }
    
    func getHeartRate(startDate: Date,
                      endDate: Date)
    -> AnyPublisher<[Double], HKError> {
        return self.fetchHeartRate(startDate: startDate, endDate: endDate)
            .map { samples in
                self.getHeartRateBPM(samples: samples)
            }
            .eraseToAnyPublisher()
    }
    
    // 특정 시간의 심박수 fetch
    private func fetchHeartRate(startDate: Date,
                                endDate: Date)
    -> Future<[HKQuantitySample], HKError> {
        return Future { promise in
            let predicate = HKQuery.predicateForSamples(withStart: startDate,
                                                        end: endDate,
                                                        options: .strictEndDate)
            
            self.healthKitProvider.getQuantityTypeSamples(identifier: .heartRate,
                                                          predicate: predicate) { samples, error in
                if let error = error {
                    // FIXME: 테스트 중간에 에러나면 끊기는 문제 때문에 주석처리
//                    promise(.failure(error))
                }
                promise(.success(samples))
            }
        }
    }
    
    // 분당 중복되는 심박수 처리
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
    

    // MARK: - 지금은 사용 x, 하루 심박동/심박변이/휴식기 심박수 fetch
    /*
    func getHeartRateData() -> Future<[HKQuantitySample], Error> {
        return Future { promise in
            let startDate = getYesterdayStartAM(Date())
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
    */
}
