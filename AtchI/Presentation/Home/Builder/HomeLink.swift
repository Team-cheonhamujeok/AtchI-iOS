//
//  HomeLink.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/06/06.
//

import Foundation
import SwiftUI

import StackCoordinator

enum HomeLink: LinkProtocol {
    
    case healthInfo
    case quiz(_ : Quiz, _ : BaseCoordinator<QuizLink>)
    case selfTest(_ : BaseCoordinator<SelfTestLink>)
    
    func matchView() -> any View {
        switch self {
        case .healthInfo:
            return HealthInfoView()
        case let .quiz(quiz, coordinator):
            return QuizBuilder(
                quiz: quiz,
                coordinator: coordinator
            )
        case let .selfTest(coordinator):
            return SelfTestBuilder(
                coordinator: coordinator
            )
        }
    }
}
