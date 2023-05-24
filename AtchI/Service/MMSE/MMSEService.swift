//
//  MMSEService.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/05/24.
//

import Foundation

enum MMSEViewType: Equatable {
    
    case reply(Reply)
    case arithmetic(Arithmetic)
    case show(Show)
    case image(Image)
    case undefined
    
    enum Reply: String, CaseIterable {
        case year
        case day
        case week
        case month
        case country
        case city
        case airplane
        case pencil
        case tree
    }
    
    enum Arithmetic: String, CaseIterable {
        case subtraction
    }
    
    enum Show: String, CaseIterable {
        case text
    }
    
    enum Image: String, CaseIterable {
        case clock
        case mirror
    }
}

struct MMSEQuestionModel {
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
    
    /// identifier을 MMSEViewType에 매핑하여 반환합니다.
    var viewType: MMSEViewType {
        if identifier.contains("REPLY") {
            // String 형 rawValue를 이용해 매핑
            for replyCase in MMSEViewType.Reply.allCases {
                if identifier.contains(replyCase.rawValue.uppercased()) {
                    return .reply(replyCase)
                }
            }
        }
        else if identifier.contains("IMAGE") {
            for replyCase in MMSEViewType.Reply.allCases {
                if identifier.contains(replyCase.rawValue.uppercased()) {
                    return .reply(replyCase)
                }
            }
        }
        else if identifier.contains("ARITHMETIC") {
            return .arithmetic(.subtraction)
        }
        else if identifier.contains("SHOW") {
            return .show(.text)
        }
        
        return .undefined
    }
}


class MMSEService {
    
    var bundelHelper = BundelHelper()
    
    /// MMSE plist 파일에 있는 식별자와 질문을 파싱해 MMSEQuestionModel로 변환합니다.
    func getMMSEQuestions() -> [MMSEQuestionModel] {
        // plist 파일 가져오기 & 파싱
        let plist = bundelHelper.parsePlist("MMSEQuestions")
        
        return plist.enumerated().compactMap { idx, item -> MMSEQuestionModel? in
            guard let identifier = item["identifier"],
                  let question = item["question"],
                  let answer = item["answer"]
            else { return nil }
            
            return MMSEQuestionModel(identifier: identifier,
                                     order: "\(idx+1)번째 질문",
                                     question: question,
                                     answer: answer)
        }
    }
    
    
}
