//
//  MMSEInfoViewModel.swift
//  AtchI
//
//  Created by 강민규 on 2023/05/25.
//

import Foundation

import Combine
import Moya
import StackCoordinator

class MMSEInfoViewModel: ObservableObject {
    
    let service: MMSEService
    var subject = CurrentValueSubject<Bool, Never>(false)
    var disposeBag = Set<AnyCancellable>()
    let mid = UserDefaults.standard.integer(forKey: "mid")
    var coordinator: BaseCoordinator<DiagnosisLink>
    
    @Published var testResults: [TestRowModel] = []
    
    init(service: MMSEService, coordinator: BaseCoordinator<DiagnosisLink>) {
        self.service = service
        self.coordinator = coordinator
        bind()
    }
    
    private func bind() {
        subject.sink(receiveValue: { isRequest in
            if isRequest {
                self.getData
                    .assign(to: &self.$testResults)
            }
        })
        .store(in: &disposeBag)
    }
    
    func requestData() {
        subject.send(true)
    }
    
    private lazy var getData: AnyPublisher<[TestRowModel], Never> = {
        return self.service
            .reqeustMMSEResults(mid: self.mid)
            .map{ $0.data }
            .decode(type: [MMSEInfoGetModel].self, decoder: JSONDecoder())
            .map{ self.makeUIDatas(datas: $0) }
            .map{$0.sorted {$0.id > $1.id }}
            .replaceError(with: [])
            .eraseToAnyPublisher()
    }()
    
    func makeUIDatas(datas: [MMSEInfoGetModel]) -> [TestRowModel] {
        var response: [TestRowModel] = []
        datas.forEach {
            let id = $0.mmseid
            let date = $0.date
            let point = $0.result
            
            response.append(TestRowModel(id: id,
                                           date: date,
                                           point: point))
        }

        return response
    }
}
