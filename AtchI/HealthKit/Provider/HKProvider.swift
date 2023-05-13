//
//  HealthKitProvider.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/04/16.
//

import Foundation
import Combine
import HealthKit

protocol HKProviderProtocol {
    func getCategoryTypeSamples(identifier: HKCategoryTypeIdentifier,
                               predicate: NSPredicate,
                               completion: @escaping ([HKCategorySample], HKError?) -> Void)
    func getQuantityTypeStatisticsSamples(identifier: HKQuantityTypeIdentifier,
                               predicate: NSPredicate,
                               completion: @escaping ((Double, HKError?) -> Void))
}



class HKProvider: HKProviderProtocol{
    // MARK: - Properties
    let healthStore = HKHealthStore()
    
    //MARK: - Category Sample
    func getCategoryTypeSamples(identifier: HKCategoryTypeIdentifier,
                               predicate: NSPredicate,
                               completion: @escaping ([HKCategorySample], HKError?) -> Void) {
        // identifier로 Type 정의
        guard let sleepType = HKObjectType.categoryType(forIdentifier: identifier) else {
            fatalError("""
                Unexpected identifier \(identifier).
                Please check if you have entered the correct identifier.
            """)
        }
        
        // 최신 데이터를 먼저 가져오도록 sort 기준 정의
        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierEndDate, ascending: false)
        
        // 쿼리 수행 완료시 실행할 콜백 정의
        let query = HKSampleQuery(sampleType: sleepType,
                                  predicate: predicate,
                                  limit: HKObjectQueryNoLimit,
                                  sortDescriptors: [sortDescriptor]) { (_, samples, error) -> Void in
            if let error = error {
                // 에러 처리를 수행합니다.
                completion([], HKError.providerFetchSamplesFailed(error: error))
            }
            
            if let result = samples {
                // 결과가 비어있을 시 error throw
                if result.isEmpty {
                    completion([], HKError.providerDataNotFound)
                }
                
                let categorySamples = result.compactMap { $0 as? HKCategorySample }
                completion(categorySamples, nil)
            }
        }
        
        // HealthKit store에서 쿼리를 실행
        healthStore.execute(query)
    }

    // MARK: - Quantity Type Sample
    func getQuantityTypeStatisticsSamples(identifier: HKQuantityTypeIdentifier,
                               predicate: NSPredicate,
                               completion: @escaping ((Double, HKError?) -> Void)) {
        
        // Identifier로 Type 분류
        guard let quantityType = HKQuantityType.quantityType(forIdentifier: identifier) else {
            fatalError("""
                Unexpected identifier \(identifier).
                Please check if you have entered the correct identifier.
            """)
        }
        
        // Quantity Type과 날짜 Predicate로 query 작성,
        let query = HKStatisticsQuery(quantityType: quantityType,
                                      quantitySamplePredicate: predicate,
                                      options: .cumulativeSum) { _, result, error in
            
            /// 결과가 잘 들어왔는지 옵셔널 바인딩
            /// resulut : 순수 결과 데이터
            guard let result = result else {
                print("'HealthKitProvider': Result가 생성되지 않았습니다.")
                return
            }
            
            /// 합이 잘 들어왔는지 옵셔널 바인딩
            /// sum: 기간동안 한 Activity의 양
            guard let sum = result.sumQuantity() else {
                print("'HealthKitProvider': sumQuantity가 생성되지 않았습니다.")
                return
            }
           
            
            // 단위
            let unit: HKUnit = {
                // ID에 따른 단위 설정 후 Publisher에 맞게 send
                switch identifier {
                case .stepCount:
                    return .count()
                case .activeEnergyBurned:
                    return .kilocalorie()
                case .distanceWalkingRunning:
                    return .meter()
                default:
                    fatalError("Unexpected identifier \(identifier)")
                }
            }()

            // escaping closure 내보내기
            completion(sum.doubleValue(for: unit), nil)

        }
        
        // HealthKit store에서 쿼리를 실행
        healthStore.execute(query)
    }
    
    func getQuantityTypeSamples(identifier: HKQuantityTypeIdentifier,
                                    predicate: NSPredicate,
                                    completion: @escaping ([HKQuantitySample], HKError?) -> Void) {

        // Identifier로 Type 분류
        guard let quantityType = HKObjectType.quantityType(forIdentifier: identifier) else {
            fatalError("""
                Unexpected identifier \(identifier).
                Please check if you have entered the correct identifier.
            """)
        }

        // 최신 데이터를 먼저 가져오도록 sort 기준 정의
        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierStartDate, ascending: true)

        // 쿼리 수행 완료시 실행할 콜백 정의
        let query = HKSampleQuery(sampleType: quantityType,
                                  predicate: predicate,
                                  limit: HKObjectQueryNoLimit,
                                  sortDescriptors: [sortDescriptor]) { (_, samples, error) -> Void in
            if let error = error {
                // 에러 처리를 수행합니다.
                completion([], HKError.providerFetchSamplesFailed(error: error))
                return
            }
            if let result = samples {
                
                // 결과가 비어있을 시 error throw
                if result.isEmpty {
                    completion([], HKError.providerDataNotFound)
                }
                
                let quantitySamples = result.compactMap { $0 as? HKQuantitySample }
                completion(quantitySamples, nil)
            }
        }
        // HealthKit store에서 쿼리를 실행
        healthStore.execute(query)

    }
    
    
}
