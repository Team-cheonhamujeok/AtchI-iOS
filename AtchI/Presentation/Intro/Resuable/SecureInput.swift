//
//  SecureInput.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/03/29.
//

import SwiftUI

struct SecureInput: View {
    var title: String
    var placeholder: String
    @State private var password: String = ""
    @State private var error: String = ""
    @State private var showPassword = false
    @FocusState private var isFocused: Bool
    
    var body: some View {
        VStack (alignment: .leading) {
            // Input title
            Text(title)
                .font(.bodyLarge)
            
            // Input rectangle
            ZStack {
                // Outline
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.white)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .strokeBorder(
                                isFocused ?
                                Color.mainPurple:
                                    Color.grayDisabled,
                                lineWidth: 2).animation(.easeInOut(duration: 0.2))
                    )
                
                // Password input
                HStack {
                    if showPassword {
                        TextField(placeholder, text: $password)
                            .padding(.horizontal, 16)
                            .focused($isFocused)
                    } else {
                        SecureField(placeholder, text: $password)
                            .padding(.horizontal, 16)
                            .focused($isFocused)
                    }
                    Button(action: {
                        self.showPassword.toggle()
                    }, label: {
                        contentViewIcon()
                    })
                    
                }
                .padding(.trailing, 20)
            }.frame(maxWidth: .infinity,
                    minHeight: 65,
                    maxHeight: 65)
            
            // Error message
            if !error.isEmpty {
                Text(error)
                    .foregroundColor(.red)
                    .font(.subheadline)
            }
        }
    }
    
    // Password show/hide icon
    @ViewBuilder
    func contentViewIcon() -> some View {
        if showPassword {
            Image(systemName: "eye")
                .foregroundColor(.secondary)
        } else {
            Image(systemName: "eye.slash")
                .foregroundColor(.secondary)
        }
    }
    
}

