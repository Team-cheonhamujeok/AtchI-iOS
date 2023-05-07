//
//  DiagnosisTestData.swift
//  AtchIServiceTests
//
//  Created by 강민규 on 2023/05/03.
//
@testable import AtchI
import Foundation

struct DiagnosisTestData {
    /// Post 할 때 사용할 Sample Test Data
    /// case: addDiagnosis 에 사용됩니다.
    static var postSampleData: DiagnosisPostModel = DiagnosisPostModel(mid: 39,
                                                                answerlist: [0,1,2,9,0,
                                                                             1,2,9,0,1,
                                                                             2,9,0,1,2],
                                                                       date: "2020-01-02T00:00:00.000+00:00")
    
    static var realData: DiagnosisPostModel = DiagnosisPostModel(mid: 1,
                                                                 answerlist: [1, 0, 0, 0, 0,
                                                                              0, 0, 0, 0, 0,
                                                                              0, 0, 0, 0, 1], date: "2023-05-07T20:43:57.984+09:00")
}
