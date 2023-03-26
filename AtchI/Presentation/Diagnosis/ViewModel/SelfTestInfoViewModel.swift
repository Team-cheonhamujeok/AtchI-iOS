//
//  SelfTestViewModel.swift
//  AtchI
//
//  Created by 강민규 on 2023/03/21.
//

import Foundation

class SelfTestInfoViewModel: ObservableObject {
    //MARK: - Data
    // 자가진단 데이터 리스트 (현재 더미 데이터)
    @Published var selfTestResults: [SelfTestResult] = [SelfTestResult(day: "23년 04월 01일", point: 4, level: "치매 위험단계"),
                                            SelfTestResult(day: "22년 02월 01일", point: 2, level: "치매 안심단계"),
                                            SelfTestResult(day: "21년 02월 01일", point: 0, level: "치매 안심단계"),
                                            SelfTestResult(day: "20년 02월 01일", point: 8, level: "치매 위험단계")
                                            ]
    
    // 자가진단을 한 적이 있는가?
    @Published var isTest: Bool = true
    
}
