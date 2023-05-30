//
//  TextInputWithSuffix.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/05/23.
//

import SwiftUI
import Combine


struct TextInputWithSuffix: View {

    @Binding var text: String
    @Binding var keyboardType: UIKeyboardType
    var suffix: String = ""
    
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
                TextField("", text: $text)
                        .font(.titleSmall)
                        .foregroundColor(.mainPurple)
                        .keyboardType(keyboardType)
                        .padding(.horizontal, 16)
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: .infinity,
                               minHeight: 65,
                               maxHeight: 65)
                        .focused($isFocused)
                        // 키패드 변경 로직
                         .onChange(of: keyboardType) { newKeyboardType in
                             DispatchQueue.main.async {
                                 if isFocused {
                                     isFocused = false
                                     DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                                         isFocused = true
                                     }
                                 }
                             }
                         }
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
