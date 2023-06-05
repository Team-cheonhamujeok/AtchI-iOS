//
//  PredictionVM.swift
//  AtchI
//
//  Created by 강민규 on 2023/06/05.
//

import Foundation
import Combine

import Factory

/// - Note: ViewModel 분리가 타당한가?
class PredictionVM: ObservableObject {
    
    // MARK: - Dependency
    @Injected(\.predictionService) private var predictionService
    
    // MARK: - Input State
    @Subject var viewOnAppear: Void = ()
    
    // MARK: - Ouput State
    @Published var startDate: String = ""
    @Published var endDate: String = ""
    @Published var notDementia: Double = 0.0
    @Published var beforeDementia: Double  = 0.0
    @Published var dementia: Double = 0.0
    
    @Published private var results: [PredictionModel] = []
    
    @Published var resultLevel: AIResultLevel?
    
    var cancellables = Set<AnyCancellable>()
    
    // MARK: - Constructor
    init() {
        bind()
    }
    
    // MARK: - Private
    private func bind() {
        
        getAIResult()
            .sink(receiveCompletion: { _ in
            
            }, receiveValue: { predictions in
                self.results = predictions.sorted { $0.pid > $1.pid }
            })
            .store(in: &cancellables)
        
        $results
            .compactMap{ $0.first }
            .map{
                if $0.dementia == max($0.dementia, $0.beforeDementia, $0.notDementia) {
                    return AIResultLevel.dementia
                } else if $0.beforeDementia == max($0.dementia, $0.beforeDementia, $0.notDementia) {
                    return AIResultLevel.beforeDementia
                } else {
                    return AIResultLevel.notDementia
                }
            }
            .assign(to: \.resultLevel, on: self)
            .store(in: &cancellables)
        
        $results
            .compactMap{ $0.first }
            .map{$0.dementia}
            .map{Double(Int($0 * 1000)) / Double(10)}
            .receive(on: DispatchQueue.main)
            .assign(to: \.dementia, on: self)
            .store(in: &cancellables)
        
        $results
            .compactMap{ $0.first }
            .map{$0.beforeDementia}
            .map{Double(Int($0 * 1000)) / Double(10)}
            .receive(on: DispatchQueue.main)
            .assign(to: \.beforeDementia, on: self)
            .store(in: &cancellables)
        
        $results
            .compactMap{ $0.first }
            .map{$0.notDementia}
            .map{Double(Int($0 * 1000)) / Double(10)}
            .receive(on: DispatchQueue.main)
            .assign(to: \.notDementia, on: self)
            .store(in: &cancellables)
        
        $results
            .compactMap{ $0.first }
            .map{$0.startDate}
            .map{DateHelper.convertFormat2(string: $0)}
            .receive(on: DispatchQueue.main)
            .assign(to: \.startDate, on: self)
            .store(in: &cancellables)
        
        $results
            .compactMap{ $0.first }
            .map{$0.endDate}
            .map{DateHelper.convertFormat2(string: $0)}
            .receive(on: DispatchQueue.main)
            .assign(to: \.endDate, on: self)
            .store(in: &cancellables)
    }
    
    private func getAIResult() -> AnyPublisher<[PredictionModel], PredictionError> {
        return predictionService
                    .reqeustPredictions(mid: 1)
                    .map { result in
                        if result.success {
                            return result.response
                        } else {
                            print("getAIResult가 실패했습니다. : ", result.error)
                            return []
                        }
                    }
                    .eraseToAnyPublisher()
    }
}
