//
//  MMSEInfoViewModel.swift
//  AtchI
//
//  Created by 강민규 on 2023/05/25.
//

import Foundation
import SwiftUI

class MMSEInfoViewModel: ObservableObject {
    
    let service: DiagnosisServiceType
    
    @Published var testResults: [SelfTestResult] = []
    
    init(service: DiagnosisServiceType) {
        self.service = service
        
        testResults.append(SelfTestResult(id: 0, mid: 1, date: "0", point: 1, level: "1"))
    }

    //TODO: 서버에서 데이터 들고오기 
}
