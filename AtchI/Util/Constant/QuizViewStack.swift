//
//  QuizViewStack.swift
//  AtchI
//
//  Created by 이봄이 on 2023/04/19.
//

import Foundation

enum QuizViewStack {
    case quizView
    case quizDoneView
}

struct QuizStack: Equatable, Hashable {
    static func == (lhs: QuizStack, rhs: QuizStack) -> Bool {
        if lhs.id == rhs.id {
            return true
        } else {
            return false
        }
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    let id: Int
    let identifier: QuizViewStack
    let content: Quiz
}
