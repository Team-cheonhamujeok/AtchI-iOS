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
    @Binding var secureText: String
    @Binding var errorMessage: String
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
                                Color(hex: "#7544C6"):
                                    Color.mainPurpleLight,
                                lineWidth: 2)
                            .background(Color.mainBackground)
                            .animation(.easeInOut(duration: 0.2),
                                       value: isFocused)
                    )
                
                // Password input
                HStack {
                    if showPassword {
                        TextField(placeholder,
                                  text: $secureText)
                            .padding(.horizontal, 16)
                            .focused($isFocused)
                    } else {
                        SecureField(placeholder,
                                    text: $secureText)
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
            Text(errorMessage)
                .foregroundColor(.red)
                .font(.bodySmall)
//                .frame(minHeight: 20)
                .opacity(!errorMessage.isEmpty ? 1.0 : 0.0)
                .animation(.easeInOut(duration: 0.3),
                           value: errorMessage)
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
