//
//  SelfTestViewModel.swift
//  AtchI
//
//  Created by 강민규 on 2023/03/21.
//

import Foundation

class SelfTestViewModel: ObservableObject {
    @Published var selfTests: [SelfTest] = [SelfTest(day: "23년 04월 01일", point: 4, level: "치매 위험단계"),
                                            SelfTest(day: "22년 02월 01일", point: 2, level: "치매 안심단계"),
                                            SelfTest(day: "21년 02월 01일", point: 0, level: "치매 안심단계"),
                                            SelfTest(day: "20년 02월 01일", point: 8, level: "치매 위험단계")
                                            ]
    
    
}
