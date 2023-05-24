//
//  ArithmeticAnswerInput.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/05/24.
//

import SwiftUI

extension MMSEViewType.Arithmetic {
    
    var keyboardType: UIKeyboardType {
        return .numberPad
    }
}

struct ArithmeticAnswerInput: View {
    
    @Binding var text: String
    let viewType: MMSEViewType.Arithmetic
    
    var body: some View {
        TextInputWithSuffix(text: $text,
                            keyboardType: viewType.keyboardType)
    }
}
