//
//  SelfTestInfoViewModel.swift
//  AtchI
//
//  Created by 강민규 on 2023/05/15.
//

import Foundation

import Combine

class SelfTestInfoViewModel: ObservableObject {
    
    let service: DiagnosisServiceType
    var disposeBag = Set<AnyCancellable>()
    
    /// 사용자가 이 때까지 한 자가진단 결과 리스트
    @Published var selfTestResults: [SelfTestResult] = []
    
    init(service: DiagnosisServiceType) {
        self.service = service
    }
    
    /// 서버로부터 Get 하는 함수
    func getData() {
        // TODO: mid 값 넣기
        let request = service.getDiagnosisList(mid: 2)
    
        request
            .handleEvents(receiveSubscription: { _ in
              print("Network request will start")
            }, receiveOutput: { _ in
              print("Network request data received")
            }, receiveCancel: {
              print("Network request cancelled")
            })
            .sink(receiveCompletion: { _ in
                print("SelfTestInfoViewModel: Complete")
            }, receiveValue: { response in
                let decoder = JSONDecoder()
                if let datas = try? decoder.decode([DiagnosisGetModel].self, from: response.data) {
                    var response: [SelfTestResult] = []
                    datas.forEach {
                        let id = $0.did
                        let mid = $0.mid
                        let date = $0.date
                        let point = $0.result
                        let level = self.measureLevel(point: point).rawValue
                        
                        response.append(SelfTestResult(id: id,
                                                       mid: mid,
                                                       date: date,
                                                       point: point,
                                                       level: level))}
                    
                    // 서버 배열 교체
                    self.selfTestResults = response.sorted { $0.id > $1.id }
                    
                }
            }).store(in: &disposeBag)
    }
    
    /// point를 이용해서 최종 level 계산
    func measureLevel(point: Int) -> SelfTestLevel {
        if point <= 3 { return .safety }
        else if point <= 9 { return .dangerous }
        else { return .dementia }
    }
}
