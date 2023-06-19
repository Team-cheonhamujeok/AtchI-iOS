//
//  HomeQuizClient.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/06/15.
//

import Foundation
@preconcurrency import SwiftUI

import ComposableArchitecture
import Factory

struct HomeQuizClient {
    /// 아직 풀지 않은 퀴즈를 조회합니다.
    /// - Returns: 조회 결과를 Quiz 구조체 형식으로 반환합니다. 만약, 퀴즈를 다 풀었다면 nil을 반환합니다.
    var getUnsolvedQuiz: () async -> Quiz?
}

extension HomeQuizClient: DependencyKey {
    
    static let liveValue = Self(
        getUnsolvedQuiz: {
            @Injected(\.quizService) var quizService
            
            let mid = UserDefaults.standard.integer(forKey: "mid")
            
            do {
                let quizResult: Quiz? = try await withCheckedThrowingContinuation {
                    continuation in
                    let _ = quizService
                        .getQuiz(mid: mid)
                        .sink(receiveCompletion: { completion in
                            switch completion {
                            case .finished: break
                            case .failure(let error):
                                continuation.resume(
                                    throwing: error
                                )
                            }
                            
                        }, receiveValue: { quiz in
                            
                            if !quiz.quiz1Check {
                                continuation.resume(
                                    returning: Quiz(
                                        index: 1,
                                        content: quiz.quiz1,
                                        check: quiz.quiz1Check,
                                        solved: quiz.solve
                                    )
                                )
                            } else if !quiz.quiz2Check {
                                continuation.resume(
                                    returning: Quiz(
                                        index: 2,
                                        content: quiz.quiz1,
                                        check: quiz.quiz1Check,
                                        solved: quiz.solve
                                    )
                                )
                            } else if !quiz.quiz3Check {
                                continuation.resume(
                                    returning: Quiz(
                                        index: 3,
                                        content: quiz.quiz1,
                                        check: quiz.quiz1Check,
                                        solved: quiz.solve
                                    )
                                )
                            } else {
                                continuation.resume(throwing: QuizError.common(CommonError.networkError("실패")))
                            }
                        })
                }
                return quizResult
            } catch {
                return nil
            }
        }
    )
}

extension DependencyValues {
    var homeQuizClinet: HomeQuizClient {
        get { self[HomeQuizClient.self] }
        set { self[HomeQuizClient.self] = newValue }
    }
}
