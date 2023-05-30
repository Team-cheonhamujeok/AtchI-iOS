//
//  ImageAnswerInput.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/05/24.
//

import SwiftUI
import UIKit

extension MMSEQuestionType.Image {
    var imageName: String {
        switch self {
        case .clock: return "mmse_clock"
        case .ball: return "mmse_soccer_ball"
        }
    }
}

struct ImageAnswerInput: View {
    
    @Binding var text: String
    @Binding var keybaordType: UIKeyboardType
    let viewType: MMSEQuestionType.Image
    
    var body: some View {
        Image(viewType.imageName)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(minWidth: 250, maxWidth: 250)
            .padding(.bottom, 30)
        TextInputWithSuffix(text: $text,
                            keyboardType: $keybaordType)
    }
}

struct ImageAnswerInput_Previews: PreviewProvider {
    @State var text: String
    static var previews: some View {
        ImageAnswerInput(text: .constant(""),
                         keybaordType: .constant(.numberPad),
                         viewType: .ball)
    }
}

