//
//  ShowTextView.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/05/24.
//

import SwiftUI

extension MMSEViewType.Show {
    var text: String {
        switch self {
        case .airplane: return "비행기"
        case .pencil: return "연필"
        case .tree: return "소나무"
        }
    }
}

struct ShowTextView: View {
    
    @Binding var text: String
    let viewType: MMSEViewType.Show
    
    var body: some View {
        HStack {
            Spacer()
            Text(viewType.text)
                .font(.titleLarge)
                .foregroundColor(.mainPurple)
            Spacer()
        }
    }
}
