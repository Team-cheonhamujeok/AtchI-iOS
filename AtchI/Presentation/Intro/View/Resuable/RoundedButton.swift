//
//  RoundedButton.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/03/17.
//

import SwiftUI
import Combine

struct RoundedButton: View {
    let title: String
    var onTap: PassthroughSubject<Void, Never>? = nil
    var disabled: Bool = true
    
    var body: some View {
        Button(action: { onTap?.send() }) {
            Text(title)
                .foregroundColor(.white)
                .font(.titleSmall)
                .padding()
                .frame(maxWidth: .infinity,
                       minHeight: 65)
                .disabled(disabled)
        }
        .background(disabled
                    ? Color.grayDisabled
                    : Color.mainPurple)
        .cornerRadius(20)
    }
}

