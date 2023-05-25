//
//  ImageAnswerInput.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/05/24.
//

import SwiftUI

extension MMSEViewType.Image {
    var imageName: String {
        switch self {
        case .clock: return "mmse_clock"
        case .mirror: return ""
        }
    }
}

struct ImageAnswerInput: View {
    
    @Binding var text: String
    let viewType: MMSEViewType.Image
    
    var body: some View {
        Image(viewType.imageName)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(minWidth: 250, maxWidth: 250)
            .padding(.bottom, 30)
        TextInputWithSuffix(text: $text)
    }
}

struct ImageAnswerInput_Previews: PreviewProvider {
    @State var text: String
    static var previews: some View {
        ImageAnswerInput(text: .constant(""),
                         viewType: .clock)
    }
}
