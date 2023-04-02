//
//  TextInput.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/03/16.
//

import SwiftUI

struct TextInput: View {
    var title: String
    var placeholder: String
    @Binding var text: String
    @Binding var error: String
    @FocusState private var isFocused: Bool
    @State private var showError = false
    
    var body: some View {
        VStack (alignment: .leading) {
            // Title
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
                
                // Text Field
                    TextField(placeholder, text: $text)
                        .padding(.horizontal, 16)
                        .focused($isFocused)
            }
            .frame(maxWidth: .infinity,
                   minHeight: 65,
                   maxHeight: 65)
            
            // Show error message
            Text(error)
                .foregroundColor(.red)
                .font(.bodySmall)
                .frame(minHeight: 20)
                .opacity(!error.isEmpty ? 1.0 : 0.0)
                .animation(.easeInOut(duration: 0.3))
        }
    }
}
