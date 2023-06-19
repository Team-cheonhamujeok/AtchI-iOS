//
//  HomeReducer.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/06/15.
//

import Foundation
@preconcurrency import SwiftUI

import ComposableArchitecture
import StackCoordinator

struct HomeReducer: ReducerProtocol {
    
    var coordinator: BaseCoordinator<HomeLink>
    
    struct State: Equatable {
        var articles: [DementiaArticleModel] = []
    }
    
    enum Action: Equatable {
        case viewOnAppear
        case tapMoveHealthInfoPage
        case tapQuizShortcut
        case tapSelfDiagnosisShortcut
    }
    
    @Dependency(\.homeDementiaArticleClient) var homeDementiaArticleClient
    @Dependency(\.homeQuizClinet) var homeQuizClient
    
    func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
        switch action {

        case .viewOnAppear:
            state.articles = homeDementiaArticleClient
                .getDementiaArticles()
            return .none
            
        case .tapMoveHealthInfoPage:
            coordinator.push(HomeLink.healthInfo)
            return .none
            
        case .tapQuizShortcut:
            return .run { send in
                let quiz = await homeQuizClient.getUnsolvedQuiz()
                if let quiz = quiz {
                    coordinator.push(HomeLink.quiz(quiz))
                } else {
                    AlertHelper
                        .showAlert(
                            title: "퀴즈 모두 완료",
                            message: "오늘 퀴즈를 모두 푸셨습니다 🥳"
                        )
                }
            }
            
        case .tapSelfDiagnosisShortcut:
            coordinator.push(HomeLink.selfTest)
            return .none
        }
    }
}
