//
//  HealthKitProvider.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/04/16.
//

import Foundation
import HealthKit

class HealthKitProvider {
    let healthStore = HKHealthStore()
    
    func getCategoryTypeSample(identifier: HKCategoryTypeIdentifier,
                               predicate: NSPredicate,
                               completion: @escaping ([HKCategorySample]) -> Void) {
        // identifier로 Type 정의
        guard let sleepType = HKObjectType.categoryType(forIdentifier: identifier) else {
            // 에러 처리를 수행합니다.
            print("Invalid HKCategoryTypeIdentifier")
            return
        }
        
        // 최신 데이터를 먼저 가져오도록 sort 기준 정의
        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierEndDate, ascending: false)
        
        // 쿼리 수행 완료시 실행할 콜백 정의
        let query = HKSampleQuery(sampleType: sleepType,
                                  predicate: predicate,
                                  limit: 1000,
                                  sortDescriptors: [sortDescriptor]) { (query, tmpResult, error) -> Void in
            if let error = error {
                // 에러 처리를 수행합니다.
                print(error)
                return
            }
            if let result = tmpResult {
                let categorySamples = result.compactMap { $0 as? HKCategorySample }
                completion(categorySamples)
            }
        }
        
        // HealthKit store에서 쿼리를 실행
        healthStore.execute(query)
    }

    
    func getQuantityTypeSample(){
        
    }
}
