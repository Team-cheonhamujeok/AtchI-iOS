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
    @State private var text: String = ""
    @State private var error: String = ""
    @FocusState private var isFocused: Bool
    
    var body: some View {
        VStack (alignment: .leading) {
            Text(title)
                .font(.bodyLarge)
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.white)
                    .frame(maxWidth: .infinity, minHeight: 65)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .strokeBorder(
                                isFocused ?
                                Color.mainPurple:
                                    Color.grayDisabled,
                                lineWidth: 2).animation(.easeInOut(duration: 0.2))
                    )
                HStack {
                    TextField(placeholder, text: $text)
                        .padding(.horizontal, 16)
                        .frame(maxWidth: .infinity, maxHeight: 65)
                        .focused($isFocused)
                }
            }
            // Show error message
            if !error.isEmpty {
                Text(error)
                    .foregroundColor(.red)
                    .font(.subheadline)
            }
        }
    }
}
