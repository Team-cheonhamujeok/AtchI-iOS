//
//  ReplyAnswerInput.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/05/23.
//

import SwiftUI

extension MMSEViewType.Reply {
    var suffix: String {
        switch self {
        case .year: return "년"
        case .day: return "일"
        case .month: return "월"
        default: return ""
        }
    }
}

struct ReplyAnswerInput: View {
    
    @Binding var text: String
    let viewType: MMSEViewType.Reply
    
    var body: some View {
        TextInputWithSuffix(text: $text, suffix: viewType.suffix)
    }
}
