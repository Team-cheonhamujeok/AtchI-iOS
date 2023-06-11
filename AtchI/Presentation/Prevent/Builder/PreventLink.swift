//
//  PreventLink.swift
//  AtchI
//
//  Created by 이봄이 on 2023/06/09.
//

import Foundation
import SwiftUI

import StackCoordinator

enum PreventLink: LinkProtocol {
    
    case quiz(
        quiz: Quiz,
        coordinate: BaseCoordinator<PreventLink>
    )
    
    func matchView() -> any View {
        switch self {
        case .quiz(let quiz, let coordinate):
            return QuizBuilder(
                quiz: quiz, coordinator: BaseCoordinator(path: coordinate.$path)
            )
        }
    }
}
