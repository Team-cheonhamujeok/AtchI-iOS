//
//  TextInput.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/03/16.
//

import SwiftUI
import Combine

struct TextInput: View {
    var title: String = ""
    var placeholder: String = ""
    @Binding var text: String
    @Binding var errorMessage: String
    var onFocusOut: PassthroughSubject<String, Never>? = nil
    
    // private
    @FocusState private var isFocused: Bool
    
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
                                lineWidth: 2)
                            .animation(.easeInOut(duration: 0.3), value: isFocused)
                    )
                
                // Text Field
                    TextField(placeholder,
                              text: $text)
                        .padding(.horizontal, 16)
                        .frame(maxWidth: .infinity,
                               minHeight: 65,
                               maxHeight: 65)
                        .focused($isFocused)
                        .onSubmit {
                            onFocusOut?.send(text)
                        }
                
            }
            
            // Show error message
            Text(errorMessage)
                .foregroundColor(.red)
                .font(.bodySmall)
                .opacity(!errorMessage.isEmpty ? 1.0 : 0.0)
                .animation(.easeInOut(duration: 0.3),
                           value: isFocused)
                .frame(height: !errorMessage.isEmpty ? nil : 0)
        }
    }
}
