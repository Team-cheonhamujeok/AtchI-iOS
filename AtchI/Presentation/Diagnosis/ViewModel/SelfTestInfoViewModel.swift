//
//  SelfTestInfoViewModel.swift
//  AtchI
//
//  Created by 강민규 on 2023/05/15.
//

import Foundation
import Combine

import Moya
import StackCoordinator

class SelfTestInfoViewModel: ObservableObject {
    
    let service: DiagnosisServiceType
    var subject = CurrentValueSubject<Bool, Never>(false)
    var disposeBag = Set<AnyCancellable>()
    let mid = UserDefaults.standard.integer(forKey: "mid")
    var coordinator: BaseCoordinator<DiagnosisLink>
    
    /// 사용자가 이 때까지 한 자가진단 결과 리스트
    @Published var selfTestResults: [TestRowModel] = []
    @Published var isLoading: Bool = true
    @Published var isEmpty: Bool?
    
    init(service: DiagnosisServiceType,
         coordinator: BaseCoordinator<DiagnosisLink>) {
        self.service = service
        self.coordinator = coordinator
        bind()
    }
    
    private func bind() {
        subject
            .sink(receiveCompletion: { _ in
                
            }, receiveValue: { _ in
                self.getData()
                    .sink { value in
                        self.selfTestResults = value
                    }
                    .store(in: &self.disposeBag)
            })
            .store(in: &disposeBag)

        getData()
            .sink { _ in
                
            } receiveValue: { value in
                self.isLoading = false
            }
            .store(in: &disposeBag)
        
        getData()
            .sink { value in
                self.isEmpty = value.isEmpty
            }
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
    private func getData() -> AnyPublisher<[TestRowModel], Never> {
        return self.service.getDiagnosisList(mid: self.mid)
            .map{ $0.data }
            .decode(type: [DiagnosisGetModel].self, decoder: JSONDecoder())
            .map{ self.makeUIDatas(datas: $0) }
            .map{$0.sorted { $0.id > $1.id }}
            .replaceError(with: [])
            .eraseToAnyPublisher()
    }

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

extension SelfTestInfoViewModel: Hashable {
    static func == (
        lhs: SelfTestInfoViewModel,
        rhs: SelfTestInfoViewModel
    ) -> Bool {
        return lhs.id == rhs.id ? true : false
    }
    
    func hash(into hasher: inout Hasher) {
    }
    
    var id: String {
        String(describing: self)
    }
}
