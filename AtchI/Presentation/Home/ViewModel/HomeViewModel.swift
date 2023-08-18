//
//  HomeViewModel.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/03/13.
//

import Combine
import Foundation
import SwiftUI

import Factory
import StackCoordinator

@MainActor
class HomeViewModel: ObservableObject {
    
    // MARK: - Dependency
    @Injected(\.dementiaArticleService) private var dementiaArticleService
    @Injected(\.quizService) private var quizServcie
    var coordinator: BaseCoordinator<HomeLink>
    
    // MARK: - Input State
    
    @Subject var viewOnAppear: Void = ()
    @Subject var tapMoveHealthInfoPage: Void = ()
    @Subject var tapQuizShortcut: Void = ()
    @Subject var tapSelfDiagnosisShortcut: Void = ()
    
    // MARK: - Output State
    
    @Published var stepCount: String = ""
    @Published var heartAverage: String = ""
    @Published var sleepTotal: String = ""
    @Published var articles: [DementiaArticleModel] = []
    
    var cancellables = Set<AnyCancellable>()
    
    // MARK: - Constructor
    
    init(coordinator: BaseCoordinator<HomeLink>) {
        self.coordinator = coordinator
        getDementiaArticles()
        bind()
    }
    
    // MARK: - Prviate
    
    private func bind() {
        
        $tapMoveHealthInfoPage
            .sink {
                self.coordinator.path.append(
                    HomeLink.healthInfo
                )
            }
            .store(in: &cancellables)
        
        $tapQuizShortcut
            .flatMap {
                return self.getUnsolvedQuiz()
            }
            .sink { quiz in
                if let quiz = quiz {
                    self.coordinator.path.append(
                        HomeLink.quiz(quiz)
                    )
                } else {
                    AlertHelper
                        .showAlert(title: "퀴즈 모두 완료",
                                   message: "오늘 퀴즈를 모두 푸셨습니다 🥳", action: nil)
                }
            }
            .store(in: &cancellables)
        
        $tapSelfDiagnosisShortcut
            .print("button tap")
            .sink {
                self.coordinator.path.append(
                    HomeLink.selfTest
                )
            }
            .store(in: &cancellables)
        
        
    }
    
    // MARK: - Semantic function snippets
    
    private func getDementiaArticles() {
        self.articles = dementiaArticleService
            .getDementiaArticles()
            .shuffled()
    }
    
    //.. 🙄
    /// 아직 풀지 않은 퀴즈를 조회합니다.
    /// - Returns: 조회 결과를 Quiz 구조체 형식으로 반환합니다. 만약, 퀴즈를 다 풀었다면 nil을 반환합니다.
    private func getUnsolvedQuiz() -> AnyPublisher<Quiz?, Never> {
        let mid = UserDefaults.standard.integer(forKey: "mid")
        
        return quizServcie
            .getQuiz(mid: mid)
            .map { quiz in
                if !quiz.quiz1Check {
                    return Quiz(index: 1, content: quiz.quiz1, check: quiz.quiz1Check, solved: quiz.solve)
                } else if !quiz.quiz2Check {
                    return Quiz(index: 2, content: quiz.quiz1, check: quiz.quiz1Check, solved: quiz.solve)
                } else if !quiz.quiz3Check {
                    return Quiz(index: 3, content: quiz.quiz1, check: quiz.quiz1Check, solved: quiz.solve)
                } else { return nil }
            }
            .replaceError(with: nil)
            .eraseToAnyPublisher()
    }
    
}
