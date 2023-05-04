//
//  SelfTestViewModel.swift
//  AtchI
//
//  Created by 강민규 on 2023/03/21.
//

import Foundation

class SelfTestInfoViewModel: ObservableObject {
    //MARK: - Data
    let service: DiagnosisServiceType?
    
    //TODO: 서버로부터 받아서 selfTestResults에 넣어야함
    /// 자가진단 데이터 리스트 (현재 더미 데이터)
    @Published var selfTestResults: [SelfTestResult] = [SelfTestResult(day: "23년 04월 01일", point: 4, level: "치매 위험단계"),
                                            SelfTestResult(day: "22년 02월 01일", point: 2, level: "치매 안심단계"),
                                            SelfTestResult(day: "21년 02월 01일", point: 0, level: "치매 안심단계"),
                                            SelfTestResult(day: "20년 02월 01일", point: 8, level: "치매 위험단계")
                                            ]
    
    /// 자가진단을 한 적이 있는가?
    @Published var isTest: Bool = true
    
    // Response Data
    private var serverDatas: [DiagnosisGetModel] = []
    
    //MARK: - init
    init(service: DiagnosisServiceType?, selfTestResults: [SelfTestResult], isTest: Bool, serverDatas: [DiagnosisGetModel]) {
        self.service = service
        self.selfTestResults = selfTestResults
        self.isTest = isTest
        self.serverDatas = serverDatas
    }
    
    init(service: DiagnosisServiceType) {
        self.service = service
    }
    
    //MARK: - Server
    /// 서버로부터 Get 하는 함수
    func getData() {
        // TODO: mid 값 넣기
        let request = service?.getDiagnosisList(mid: 1)
        
        let cancellable = request?
                            .sink(receiveCompletion: { _ in
                                print("SelfTestInfoViewModel: Complete")
                            }, receiveValue: { response in
                                
                                let decoder = JSONDecoder()
                                if let datas = try? decoder.decode([DiagnosisGetModel].self, from: response.data) {
                                    self.serverDatas = datas
                                }
                            })
    }
    
    //MARK: - Convert
    /// DiagnosisGetModels을 SelfTestResults 타입으로 변환
    func convertSelfTestResult(responseData diagnosisGetModel: DiagnosisGetModel) {
        
    }
    
}
