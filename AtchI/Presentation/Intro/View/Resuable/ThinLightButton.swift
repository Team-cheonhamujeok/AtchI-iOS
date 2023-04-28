//
//  ThinLightButton.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/04/27.
//

import Foundation
import Combine
import SwiftUI

struct ThinLightButton: View {
    var title: String
    var onTap: PassthroughSubject<Void, Never>
    @Binding var disabled: Bool
    
    var body: some View {
        Button(action: {
            onTap.send()
        }) {
            Text(title)
                .foregroundColor(disabled ? .grayTextLight : .mainPurple)
                .font(.bodyMedium)
                .padding()
                .frame(maxWidth: .infinity,
                       minHeight: 30)
        }
        .disabled(disabled)
        .background(disabled ? .grayThinLine : Color.mainPurpleLight)
        .cornerRadius(20)
    }
}
