//
//  AIDiagnosisViewModel.swift
//  AtchI
//
//  Created by 강민규 on 2023/06/05.
//

import Combine

class AIDiagnosisViewModel: ObservableObject {
    
    var startDate: String = "23.02.01"
    var endDate: String = "23.03.01"
    var resultLevel: AIResultLevel?
}
