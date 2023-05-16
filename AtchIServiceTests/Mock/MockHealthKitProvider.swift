//
//  MockHealthKitProvider.swift
//  AtchIServiceTests
//
//  Created by 강민규 on 2023/04/26.
//

@testable import AtchI

import Combine
import HealthKit

class MockHealthKitProvider: HKProviderProtocol {
    /// [Mock] HealthKit Data Store입니다.
    var healthStore = MockHKStore()
    
    var cancellables = Set<AnyCancellable>()
    
    //MARK: - Sleep
    
    /// [Mock] Category Sample을 가져옵니다.
    /// Category Sample: 가능한 값이 있는 짧은 목록으로 부터 샘플
    /// - Parameters:
    ///   - identifier: HKCategory Type ID.
    ///   - predicate: 예측 기간.
    ///   - completion: @escaping ([카테고리 샘플], HKError).
    func getCategoryTypeSample(identifier: HKCategoryTypeIdentifier,
                               predicate: NSPredicate,
                               completion: @escaping ([HKCategorySample], AtchI.HKError?) -> Void) {
        
        // identifier로 Type 정의
        guard let sleepType = HKObjectType.categoryType(forIdentifier: identifier) else {
            fatalError("identifier를 찾을 수 없습니다. 올바른 identifier를 입력했는지 확인해주세요.")
        }
        
        // 최신 데이터를 먼저 가져오도록 sort 기준 정의
        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierEndDate, ascending: false)
        
        // 가짜 쿼리 생성
        let query = MockHKQuery(type: sleepType) { _, samples, err in
        
            if let err = err {
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
        
        // 가짜 Store에 query 실행
        // query에 해당하는 값이 있으면 resultsHandler에 값이 들어감
        healthStore.execute(query)
    }
    
    //MARK: - Activity
    
    /// [Mock] Quantity Sample을 가져옵니다.
    /// - Parameters:
    ///   - identifier: HKQuantity Type ID.
    ///   - predicate: 예측 기간.
    ///   - completion: @escaping ([카테고리 샘플], HKError).
    func getQuantityTypeSample(identifier: HKQuantityTypeIdentifier,
                               predicate: NSPredicate,
                               completion: @escaping ((HKStatistics?, AtchI.HKError?) -> Void)) {
        
        // Identifier로 Type 분류
        guard let quantityType = HKQuantityType.quantityType(forIdentifier: identifier) else {
            print("'HealthKitProvider': 올바르지 않은 ID입니다.")
            return
        }
        
        let query = MockHKStatisticsQuery(type: quantityType) { _, result, err in
            guard let result = result else {
                completion(nil, HKError.providerFetchSamplesFailed)
                return
            }
            completion(result, nil)
        }
        
        // 가짜 Store에 query 실행
        // query에 해당하는 값이 있으면 resultsHandler에 값이 들어감
        healthStore.execute(query)
    }
    
    //MARK: - Heart
    
    /// [Mock] Heart Quantity Sample을 가져옵니다.
    /// - Parameters:
    ///   - identifier: HKQuantity Type ID.
    ///   - predicate: 예측 기간.
    ///   - completion: @escaping ([카테고리 샘플], HKError).
    func getQuantityTypeSampleHeart(identifier: HKQuantityTypeIdentifier,
                                    predicate: NSPredicate,
                                    completion: @escaping ([HKQuantitySample], AtchI.HKError?) -> Void) {
        
        // Identifier로 Type 분류
        guard let quantityType = HKObjectType.quantityType(forIdentifier: identifier) else {
            print("'HealthKitProvider': 올바르지 않은 ID입니다.")
            return
        }

        // 최신 데이터를 먼저 가져오도록 sort 기준 정의
        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierStartDate, ascending: true)

       
        // 가짜 쿼리 생성
        let query = MockHKQuery(type: quantityType) { _, samples, err in
            if let err = err {
                completion([], HKError.providerFetchSamplesFailed)
            }
            if let result = samples {
                let quantitySamples = result.compactMap { $0 as? HKQuantitySample }
                if quantitySamples.isEmpty {
                    completion([], HKError.providerDataNotFound)
                }
                completion(quantitySamples, nil)
            }
        }
        
        // 가짜 Store에 query 실행
        // query에 해당하는 값이 있으면 resultsHandler에 값이 들어감
        healthStore.execute(query)
    }
    
    func getCategoryTypeSamples(
        identifier: HKCategoryTypeIdentifier,
        predicate: NSPredicate,
        completion: @escaping ([HKCategorySample], AtchI.HKError?)
        -> Void) {
        
    }
}
