//
//  SelfTestInfoViewModel.swift
//  AtchI
//
//  Created by 강민규 on 2023/05/15.
//

import Foundation

import Combine
import Moya

class SelfTestInfoViewModel: ObservableObject {
    
    let service: DiagnosisServiceType
    var subject = CurrentValueSubject<Bool, Never>(false)
    var disposeBag = Set<AnyCancellable>()
    
    /// 사용자가 이 때까지 한 자가진단 결과 리스트
    @Published var selfTestResults: [TestRowModel] = []
    @Published var isCompleted: Bool = false
    
    init(service: DiagnosisServiceType) {
        self.service = service
        bind()
    }
    
    private func bind() {
        subject
            .sink(receiveValue: { isRequest in
                if isRequest {
                    self.getData
                        .assign(to: &self.$selfTestResults)
                }
            })
            .store(in: &disposeBag)
    }
    
    // MARK: - UI
    
    /// point를 이용해서 최종 level 계산
    func measureLevel(point: Int) -> SelfTestLevel {
        if point <= 3 { return .safety }
        else if point <= 9 { return .dangerous }
        else { return .dementia }
    }
    
    //MARK: - Request
    
    /// 데이터 요청
    func requestData() {
        subject.send(true)
    }
    
    /// 서버로부터 Get 하는 함수
    private lazy var getData: AnyPublisher<[TestRowModel], Never> = {
        // TODO: mid 값 넣기
        return self.service.getDiagnosisList(mid: 2)
            .map{ $0.data }
            .decode(type: [DiagnosisGetModel].self, decoder: JSONDecoder())
            .map{ self.makeUIDatas(datas: $0) }
            .map{$0.sorted { $0.id > $1.id }}
            .replaceError(with: [])
            .eraseToAnyPublisher()
    }()

    /// UI 전용 데이터로 변환
    func makeUIDatas(datas: [DiagnosisGetModel]) -> [TestRowModel] {
        var response: [TestRowModel] = []
        datas.forEach {
            let id = $0.did
            let date = $0.date
            let point = $0.result
            let level = self.measureLevel(point: point).rawValue
            
            response.append(TestRowModel(id: id,
                                           date: date,
                                           point: point,
                                           level: level))
        }

        return response
    }
}
