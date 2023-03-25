//
//  RoundedButton.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/03/17.
//

import SwiftUI

struct RoundedButton: View {
    let action: () -> Void
    let title: String
    
    init(title: String, action: @escaping () -> Void) {
        self.title = title
        self.action = action
    }
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .foregroundColor(.white)
                .font(.bodyMedium)
                .padding()
                .frame(maxWidth: .infinity,
                       minHeight: 65)
        }
        .background(Color.mainPurple)
        .cornerRadius(20)
    }
}

