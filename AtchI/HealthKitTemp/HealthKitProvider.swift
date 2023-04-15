//
//  HealthKitProvider.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/04/16.
//

import Foundation
import HealthKit

class HealthKitProvicer {
    let healthStore = HKHealthStore()
    
    func getCategoryTypeSample(identifier: HKCategoryTypeIdentifier,
                               predicate: NSPredicate,
                               callback: @escaping ([HKCategorySample]) -> Void){
        // identifier로 Type 정의
        if let sleepType = HKObjectType.categoryType(forIdentifier: identifier) {
            // 데이터를 필터링할 조건(predicate)를 설정할 수 있음. 여기선 일주일 데이터를 받아오도록 설정
            /// ➡️ 여기서부터
//            let calendar = Calendar.current
//            let endDate = Date() // 현재 시간
//            let startDate = calendar.date(byAdding: .day, value: -7, to: endDate) // 7일 전 시간
//            let predicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate)
            /// ➡️ 여기까지는 상위에서 주입
            // 최신 데이터를 먼저 가져오도록 sort 기준 정의
            let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierEndDate, ascending: false)
            // 쿼리 수행 완료시 실행할 콜백 정의
            let query = HKSampleQuery(sampleType: sleepType,
                                      predicate: predicate,
                                      limit: 1000,
                                      sortDescriptors: [sortDescriptor]) { (query, tmpResult, error) -> Void in
                if error != nil {
                    // 에러 처리를 수행합니다.
                    print(error)
                    return
                }
                if let result = tmpResult {
                    for item in result {
                        if let sample = item as? HKCategorySample {
                            // 가져온 데이터 출력
                            print("Sleep value: \(sample.value)")
                            print("Start Date: \(sample.startDate)")
                            print("End Date: \(sample.endDate)")
                            print("Metadata: \(String(describing: sample.metadata))")
                            print("UUID: \(sample.uuid)")
                            print("Source: \(sample.sourceRevision)")
                            print("Device: \(String(describing: sample.device))")
                            print("---------------------------------\n")
                            
                        }
                    }
                    callback(result)
                }
            }
            // HealthKit store에서 쿼리를 실행
            healthStore.execute(query)
        }
    }
    
    func getQuantityTypeSample(){
        
    }
}
