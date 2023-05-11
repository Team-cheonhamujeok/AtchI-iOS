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
    func getQuantityTypeSample(identifier: HKQuantityTypeIdentifier,
                               predicate: NSPredicate,
                               completion: @escaping ((Double) -> Void))
}



class HKProvider {
    // MARK: - Properties
    let healthStore = HKHealthStore()
    
    //MARK: - Category Sample
    func getCategoryTypeSample(identifier: HKCategoryTypeIdentifier,
                               predicate: NSPredicate,
                               completion: @escaping ([HKCategorySample], HKError?) -> Void) {
        // identifier로 Type 정의
        guard let sleepType = HKObjectType.categoryType(forIdentifier: identifier) else {
            fatalError("identifier를 찾을 수 없습니다. 올바른 identifier를 입력했는지 확인해주세요.")
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
                completion([], HKError.providerFetchSamplesFailed)
            }
            if let result = samples {
                let categorySamples = result.compactMap { $0 as? HKCategorySample }
                
                if categorySamples.isEmpty {
                    completion([], HKError.providerDataNotFound)
                }
                
                completion(categorySamples, nil)
            }
        }
        
        // HealthKit store에서 쿼리를 실행
        healthStore.execute(query)
    }

    // MARK: - Quantity Type Sample
    func getQuantityTypeSample(identifier: HKQuantityTypeIdentifier,
                               predicate: NSPredicate,
                               completion: @escaping ((Double) -> Void)) {
        
        // Identifier로 Type 분류
        guard let quantityType = HKQuantityType.quantityType(forIdentifier: identifier) else {
            print("'HealthKitProvider': 올바르지 않은 ID입니다.")
            return
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
            completion(sum.doubleValue(for: unit))

        }
        
        // HealthKit store에서 쿼리를 실행
        healthStore.execute(query)
    }
    
    func getQuantityTypeSampleHeart(identifier: HKQuantityTypeIdentifier,
                                    predicate: NSPredicate,
                                    completion: @escaping ([HKQuantitySample]) -> Void) {

        // Identifier로 Type 분류
        guard let quantityType = HKObjectType.quantityType(forIdentifier: identifier) else {
            print("'HealthKitProvider': 올바르지 않은 ID입니다.")
            return
        }

        // 최신 데이터를 먼저 가져오도록 sort 기준 정의
        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierStartDate, ascending: true)

        // 쿼리 수행 완료시 실행할 콜백 정의
        let query = HKSampleQuery(sampleType: quantityType,
                                  predicate: predicate,
                                  limit: HKObjectQueryNoLimit,
                                  sortDescriptors: [sortDescriptor]) { (query, tmpResult, error) -> Void in
            if let error = error {
                // 에러 처리를 수행합니다.
                print("error: \(error.localizedDescription)")
                return
            }
            if let result = tmpResult {
//                print("result \(tmpResult)")
                let quantitySamples = result.compactMap { $0 as? HKQuantitySample }
//                print("quantity samples \(quantitySamples)")
                completion(quantitySamples)
            }
        }
        // HealthKit store에서 쿼리를 실행
        healthStore.execute(query)

    }
    
    
}
