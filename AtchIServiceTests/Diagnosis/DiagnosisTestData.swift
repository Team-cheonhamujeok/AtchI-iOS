//
//  DiagnosisTestData.swift
//  AtchIServiceTests
//
//  Created by 강민규 on 2023/05/03.
//
@testable import AtchI
import Foundation

extension DiagnosisAPI {
    /// Post 할 때 사용할 Sample Test Data
    /// case: addDiagnosis 에 사용됩니다.
    var postSampleData: Data {
        Data(
            """
            {
                "mid": 1,
                "answerlist" : [0,1,2,9,0,1,2,9,0,1,2,0,1,2,9],
                "date": "2020-01-02"
            }
            """.utf8
        )
    }
}
