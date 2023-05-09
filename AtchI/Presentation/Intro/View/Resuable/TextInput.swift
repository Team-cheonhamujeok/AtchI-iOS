//
//  TextInput.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/03/16.
//

import SwiftUI
import Combine

struct TextInput: View {
    // let: 할당 이후 변하지 않는 값
    let title: String
    let placeholder: String
    // @Binding: 상위에 전달해야하는 값
    @Binding var text: String
    // var: 상위에 전달할 필요가 없고, 변해야하는 값
    var errorMessage: String
    // var+초기값: 상위에 전달할 필요가 없고, 변해야하는데 선택적으로 사용하고 싶은 값
    var disabled: Bool = false
    
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
                                isFocused
                                ? Color.mainPurple
                                : disabled
                                ? Color.grayBoldLine
                                : Color.mainPurpleLight,
                                lineWidth: 2)
                            .animation(.easeInOut(duration: 0.3), value: isFocused)
                    ).frame(maxWidth: .infinity,
                            minHeight: 65,
                            maxHeight: 65)
                
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
                        .disabled(disabled)
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
