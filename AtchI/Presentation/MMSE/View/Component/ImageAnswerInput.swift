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
        case .clock: return ""
        case .mirror: return ""
        }
    }
}

struct ImageAnswerInput: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct ImageAnswerInput_Previews: PreviewProvider {
    static var previews: some View {
        ImageAnswerInput()
    }
}
