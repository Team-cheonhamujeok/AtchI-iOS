//
//  PredictionService.swift
//  AtchI
//
//  Created by 강민규 on 2023/06/05.
//

import Foundation
import Combine

import Moya

class PredictionService {
    var provider: MoyaProvider<PredictionAPI>
    var cancellables = Set<AnyCancellable>()
    
    init(provider: MoyaProvider<PredictionAPI>) {
        self.provider = provider
    }
    
    func reqeustPredictions(mid: Int) -> AnyPublisher<PredictionResponse, PredictionError> {
        return provider.requestPublisher(.getPredictList(mid: mid))
            .tryMap { response -> PredictionResponse in
                return try response.map(PredictionResponse.self)
            }
            .mapError { error in
                return PredictionError.getFail
            }
            .eraseToAnyPublisher()
    }
}

