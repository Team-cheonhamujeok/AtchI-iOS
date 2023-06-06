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
    
//    case mmse
    case healthInfo
    case quiz(_ : Quiz, _ : BaseCoordinator<QuizLink>)
    
    func matchView() -> any View {
        switch self {
//        case .mmse : return MMSEView(, viewModel: <#MMSEViewModel#>)
        case .healthInfo:
            return HealthInfoView()
        case .quiz(let quiz, let coordinator):
            return QuizBuilder(
                quiz: quiz,
                coordinator: coordinator
            )
        }
    }
}
