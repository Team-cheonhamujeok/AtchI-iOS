//
//  HKAuthorizationProvider.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/05/01.
//

import Foundation
import HealthKit

class HKAuthorizationProvider {
    
    let healthStore = HKHealthStore()
    
    // 읽기 및 쓰기 권한 설정
    let readAndshare = Set([HKCategoryType.categoryType(forIdentifier: .sleepAnalysis)!, HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.heartRate)!, HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.heartRateVariabilitySDNN)!, HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.restingHeartRate)!,             HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount)!,
        HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.distanceWalkingRunning)!,
        HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.activeEnergyBurned)!])
    
    func setAuthorization() {
        // 데이터 접근 가능 여부에 따라 권한 요청 메소드 호출
        if HKHealthStore.isHealthDataAvailable() && !checkAuthorizationStatus() {
            requestAuthorization()
        }
    }
    
    // 권한 요청 메소드
    private func requestAuthorization() {
        self.healthStore.requestAuthorization(toShare: readAndshare, read: readAndshare) { success, error in
            if error != nil {
                print(error.debugDescription)
            }else{
                if success {
                    print("권한이 허락되었습니다")
                }else{
                    print("권한이 없습니다")
                }
            }
        }
    }
    
    // 권한이 허용되어 있는지 확인
    private func checkAuthorizationStatus() -> Bool {
        let sleepAnalysisType = HKCategoryType.categoryType(forIdentifier: .sleepAnalysis)!

        let authorizationStatus = healthStore.authorizationStatus(for: sleepAnalysisType)
        print(authorizationStatus.rawValue)

        switch authorizationStatus {
        case .notDetermined:
            // 권한이 아직 요청되지 않음
            return false
        case .sharingDenied:
            // 권한 거부됨
            return false
        case .sharingAuthorized:
            // 권한 부여됨
            return true
        default:
            return false
        }
    }
}
