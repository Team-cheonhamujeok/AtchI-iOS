//
//  QuizBuilder.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/06/07.
//

import Foundation
import SwiftUI

import StackCoordinator

struct QuizBuilder: BuilderProtocol {
    
    var quiz: Quiz
    var coordinator: BaseCoordinator<QuizLink>
    
    var body: some View {
        BaseBuilder(coordinator: coordinator) {
            QuizView(
                quiz: quiz,
                coordinator: coordinator
            )
        }
    }
}
