//
//  QuizService.swift
//  AtchI
//
//  Created by 이봄이 on 2023/05/21.
//

import Foundation
import Moya
import CombineMoya
import Combine

class QuizService: QuizServiceType {
   internal init(provider: MoyaProvider<QuizAPI>, cancellables:
                    Set<AnyCancellable> = Set<AnyCancellable>()) {
        self.provider = provider
        self.cancellables = cancellables
    }
    
    let provider: MoyaProvider<QuizAPI>
    init(provider: MoyaProvider<QuizAPI>) {
        self.provider = provider
    }
    
    var cancellables = Set<AnyCancellable>()
    
    func getQuiz(mid: Int) -> AnyPublisher<GetQuizResponseModel, Error> {
        return provider.requestPublisher(.getQuiz(mid))
            .tryMap { response -> GetQuizResponseModel in
                return try
                response.map(GetQuizResponseModel.self)
            }
            .mapError { error in
                print(error)
                return QuizError.getQuiz(.fetchFailed)
            }
            .eraseToAnyPublisher()
    }
    
    func checkQuiz(quizCheckModel: QuizCheckRequestModel) -> AnyPublisher<QuizCheckResponseModel, Error> {
        return provider.requestPublisher(.checkQuiz(quizCheckModel))
            .tryMap { response in
                let decodedData = try
                    response.map(QuizCheckResponseModel.self)
                if decodedData.message == "No corresponding tqid" {
                    throw QuizError.checkQuiz(.noID)
                }
                return decodedData
            }
            .mapError { error in
                if error is MoyaError {
//                    if {
//
//                    } else {
//
//                    }
                    return QuizError.checkQuiz(.checkError)
                } else {
                    return error as! QuizError
                }
            }
            .eraseToAnyPublisher()
    }
}
