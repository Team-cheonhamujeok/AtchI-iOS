//
//  HealthKitViewModelTemp.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/04/25.
//

import Foundation

/// 예시 뷰모델
class HealthKitViewModelTemp {
    let sleepService: HealthKitSleepService
    
    init(sleepService: HealthKitSleepService) {
        self.sleepService = sleepService
    }
    
    /// 예시 함수
//    func start() {
//        let pub1 = sleepService.fetchSleepDataWithCombine(date: Date())
//        let pub2 = sleepService.fetchSleepDataWithCombine(date: Date()) // 실제론 다른 서비스
//        let pub3 = sleepService.fetchSleepDataWithCombine(date: Date()) // 실제론 다른 서비스
//        
//        // 실제로 동작이 멈추는건가? cancle -> complete. callback -> 자원을 아끼는가? ->>>
//        
//        // zip3 사용 예시
//        pub1.zip(pub2, pub3) { [weak self] sleepSamples, samples2, samples3 in // 네이밍은 서비스에 맞게
//            print("sample1: \(sleepSamples), sample2: \(samples2), sample3: \(samples3)") // 값 3개가 다 도착하면 실행
//            
//            let sleepEndDate = self?.sleepService.getSleepEndDate(samples: sleepSamples)
//            let sleepCoreQuentity = self?.sleepService.getSleepCoreQuentity(samples: sleepSamples)
//            // ... 쭉쭉 필요한 정보 계산
//            
//            
//            
//            // Life Pattern DTO(Model) 생성
//            
//            
//            
//            // 서버 저장 request 호출!
//            
//            
//            
//            
//        }.sink {}
//    }
}
