//
//  HKHeartRateService.swift
//  AtchI
//
//  Created by 이봄이 on 2023/04/30.
//

import Foundation
import Combine
import HealthKit

class HKHeartRateService: HKHeartRateServiceProtocol {
    
    var core: HKHeartRateCoreProtocol
    
    let provider: HKProvider
    let heartRateQuantity = HKUnit(from: "count/min")
    let dateHelper: DateHelperType
    
    init(
        core: HKHeartRateCoreProtocol,
        provider: HKProvider,
        dateHelper: DateHelperType
    ) {
        self.core = core
        self.provider = provider
        self.dateHelper = dateHelper
    }
    
    func getHeartRateAveragePerMin(startDate: Date,
                      endDate: Date)
    -> AnyPublisher<[Double], HKError> {
        return self
            .fetchHeartRate(
                startDate: startDate,
                endDate: endDate)
            .map { samples in
                self.core.getHeartRateBPM(
                    samples: samples.map { $0.maapedHeartRateEntity }
                )
            }
            .eraseToAnyPublisher()
    }
    
    func getHeartRateVariability(date: Date) -> Future<[Double], HKError> {
        return Future { promise in
            let startDate = self.dateHelper.getYesterdayStartAM(date)
            let endDate = self.dateHelper.getYesterdayEndPM(date)
            let predicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: .strictEndDate)

            self.provider
                .getQuantityTypeSamples(
                    identifier: .heartRateVariabilitySDNN,
                    predicate: predicate,
                    completion: { variabilityMS, error in
                let variabilitys = variabilityMS
                        .compactMap {
                            $0.quantity.doubleValue(
                                for: HKUnit.secondUnit(with: .milli)
                            )
                        }
                promise(Result.success(variabilitys))
            })

        }
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
     */

    /*

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

extension HKHeartRateService {
    
    // 특정 시간의 심박수 fetch
    private func fetchHeartRate(startDate: Date,
                                endDate: Date)
    -> Future<[HKQuantitySample], HKError> {
        return Future { promise in
            let predicate = HKQuery.predicateForSamples(withStart: startDate,
                                                        end: endDate,
                                                        options: .strictEndDate)
            
            self.provider.getQuantityTypeSamples(identifier: .heartRate,
                                                          predicate: predicate) { samples, error in
                if let error = error {
                    promise(.failure(error))
                }
                promise(.success(samples))
            }
        }
    }
}
