//
//  MMSEQuestionModel.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/05/26.
//

import Foundation

struct MMSEQuestionModel: Hashable {
    let identifier: String
    let order: String
    let question: String
    private let staticAnswer: String
    
    init(identifier: String, order: String, question: String, answer: String) {
        self.identifier = identifier
        self.order = order
        self.question = question
        self.staticAnswer = answer
    }
    
    var answer: String {
        return staticAnswer
    }
    
}

extension MMSEQuestionModel {
    /// identifier을 MMSEViewType에 매핑하여 반환합니다.
    var questionType: MMSEQuestionType {
// FIXME: 중복은 나중에 고칩시다..
        let subIdentifiers = identifier.components(separatedBy: "_")
        if subIdentifiers[1] == "REPLY" {
            // String 형 rawValue를 이용해 매핑
            for replyCase in MMSEQuestionType.Reply.allCases {
                if subIdentifiers[2] == replyCase.rawValue.uppercased() {
                    return .reply(replyCase)
                }
            }
        }
        else if subIdentifiers[1] == "IMAGE" {
            for imageCase in MMSEQuestionType.Image.allCases {
                if subIdentifiers[2] == imageCase.rawValue.uppercased() {
                    return .image(imageCase)
                }
            }
        }
        else if subIdentifiers[1] == "ARITHMETIC" {
            return .arithmetic(.subtraction)
        }
        else if subIdentifiers[1] == "SHOW" {
            for showCase in MMSEQuestionType.Show.allCases {
                if subIdentifiers[2] == showCase.rawValue.uppercased() {
                    return .show(showCase)
                }
            }
        }
        
        return .undefined
    }
}
