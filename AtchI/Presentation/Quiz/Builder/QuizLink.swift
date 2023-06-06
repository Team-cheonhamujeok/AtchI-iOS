//
//  QuizLink.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/06/07.
//

import Foundation
import SwiftUI

import StackCoordinator

enum QuizLink: LinkProtocol {
    
    case done(
        order: Int,
        solvedQuizCount : Int,
        coordinator: BaseCoordinator<QuizLink>
    )
    
    func matchView() -> any View {
        switch self {
        case .done(
            let order,
            let solvedQuizCount,
            let coordinator
        ):
            return QuizDoneView(
                quizOrder: order,
                solvedQuizCount: solvedQuizCount,
                coordinator: coordinator
            )
        }
    }
}
