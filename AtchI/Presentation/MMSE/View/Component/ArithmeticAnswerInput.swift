//
//  ArithmeticAnswerInput.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/05/24.
//

import SwiftUI

extension MMSEQuestionType.Arithmetic {
    
    var keyboardType: UIKeyboardType {
        return .numberPad
    }
}

struct ArithmeticAnswerInput: View {
    
    @Binding var text: String
    let viewType: MMSEQuestionType.Arithmetic
    
    var body: some View {
        TextInputWithSuffix(text: $text,
                            keyboardType: viewType.keyboardType)
    }
}
