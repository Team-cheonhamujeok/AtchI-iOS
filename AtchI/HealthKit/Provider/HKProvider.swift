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

enum HKProviderError: Error {
    /// Identifier 오류입니다.
    case identifierNotFound
    /// Healhkit Query 실패 오류입니다.
    case fetchSamplesFailed
    
    var description: String {
        switch self {
        case .identifierNotFound:
            return "identifier를 찾을 수 없습니다. 올바른 identifier를 입력했는지 확인해주세요."
        case .fetchSamplesFailed:
            return "Sample을 가져오는데 실패했습니다. 건강 데이터에 대한 접근 권한 및 디바이스 상태를 확인해주세요."
        }
    }
    
}

class HKProvider {
    // MARK: - Properties
    let healthStore = HKHealthStore()
    
    //MARK: - Category Sample
    func getCategoryTypeSample(identifier: HKCategoryTypeIdentifier,
                               predicate: NSPredicate,
                               completion: @escaping ([HKCategorySample], Error?) -> Void) throws {
        // identifier로 Type 정의
        guard let sleepType = HKObjectType.categoryType(forIdentifier: identifier) else {
            // 에러 처리를 수행합니다.
            throw HKProviderError.identifierNotFound
        }
        
        // 최신 데이터를 먼저 가져오도록 sort 기준 정의
        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierEndDate, ascending: false)
        
        // 쿼리 수행 완료시 실행할 콜백 정의
        let query = HKSampleQuery(sampleType: sleepType,
                                  predicate: predicate,
                                  limit: HKObjectQueryNoLimit,
                                  sortDescriptors: [sortDescriptor]) { (query, tmpResult, error) -> Void in
            if let error = error {
                // 에러 처리를 수행합니다.
                completion([], HKProviderError.fetchSamplesFailed)
            }
            if let result = tmpResult {
                let categorySamples = result.compactMap { $0 as? HKCategorySample }
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
}
