//
//  QuizViewType.swift
//  AtchI
//
//  Created by 이봄이 on 2023/04/29.
//

import Foundation

enum QuizViewType {
    case quizView
    case quizDoneView
}

struct QuizStack: Equatable, Hashable {
    static func == (lhs: QuizStack, rhs: QuizStack) -> Bool {
        if lhs.type == rhs.type {
            if lhs.data.index == rhs.data.index{
                return true
            }else {
                return false
            }
        } else {
            return false
        }
    }
    
    func hash(into hasher: inout Hasher) {
    }
    
    let type: QuizViewType
    let data: Quiz
}
