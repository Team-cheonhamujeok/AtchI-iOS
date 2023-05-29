//
//  TextInputWithSuffix.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/05/23.
//

import SwiftUI

struct TextInputWithSuffix: View {

    @Binding var text: String
    var suffix: String = ""
    var keyboardType: UIKeyboardType = .default
    
    // private
    @FocusState private var isFocused: Bool
    
    var body: some View {
        HStack {
            ZStack {
                // Outline
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.white)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .strokeBorder(
                                isFocused
                                ? Color.accentColor
                                : Color.mainPurpleLight,
                                lineWidth: 2)
                            .background(Color.mainBackground)
                    )
                    .frame(maxWidth: .infinity,
                            minHeight: 65,
                            maxHeight: 65)
                
                // Text Field
                    TextField("",
                              text: $text)
                        .font(.titleSmall)
                        .foregroundColor(.mainPurple)
                        .keyboardType(keyboardType)
                        .padding(.horizontal, 16)
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: .infinity,
                               minHeight: 65,
                               maxHeight: 65)
                        .focused($isFocused)
            }
            .onTapGesture {
                isFocused = true
            }
            .animation(.easeIn(duration: 0.1), value: isFocused)
            
            Text(suffix)
                .font(.titleMedium)
                .foregroundColor(isFocused
                                 ? .mainText
                                 : .grayTextLight)
        }
        
    }
}
