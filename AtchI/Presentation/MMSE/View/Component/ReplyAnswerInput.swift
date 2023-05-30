//
//  ReplyAnswerInput.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/05/23.
//

import SwiftUI

extension MMSEQuestionType.Reply {
    var suffix: String {
        switch self {
        case .year: return "년"
        case .day: return "일"
        case .month: return "월"
        case .week: return "요일"
        default: return ""
        }
    }
    
    var keyboardType: UIKeyboardType {
        switch self {
        case .year, .month, .day:
            return .numberPad
        default:
            return .default
        }
    }
}

struct ReplyAnswerInput: View {
    
    @Binding var text: String
    let viewType: MMSEQuestionType.Reply
    
    var body: some View {
        TextInputWithSuffix(text: $text,
                            suffix: viewType.suffix,
                            keyboardType: viewType.keyboardType)
    }
}
