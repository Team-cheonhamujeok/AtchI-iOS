//
//  DefaultButton.swift
//  AtchI
//
//  Created by 강민규 on 2023/03/19.
//

import SwiftUI

struct DefaultButton<Content>: View where Content: View {
    let buttonSize: ControlSize
    let buttonStyle: ButtonStyle
    let buttonColor: Color
    let isIndicate: Bool
    
    let action: () -> Void
    @ViewBuilder let content: Content
    
    var body: some View {
        
        switch buttonStyle {
        case .filled:
            if buttonColor == .mainPurpleLight {
                Button(action: action) {
                    makeLabel()
                }
                .buttonStyle(.bordered)
                .controlSize(buttonSize)
                .tint(.mainPurple)
            }
            else {
                Button(action: action) {
                    makeLabel()
                }
                .buttonStyle(.borderedProminent)
                .controlSize(buttonSize)
                .tint(buttonColor)
                .cornerRadius(20)
            }
            
        case .unfilled:
            Button(action: action) {
                makeLabel()
            }
            .buttonStyle(.borderless)
            .controlSize(buttonSize)
            .tint(buttonColor)
            .padding(
                buttonSize == ControlSize.large ?
                EdgeInsets(top: 12, leading: 18, bottom: 12, trailing: 18) : EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10)
            )
            .overlay {
                RoundedRectangle(
                    cornerRadius:
                        buttonSize == ControlSize.large ? 16 : 100)
                    .stroke(buttonColor, lineWidth: 2)
            }
        }
    }
    
    @ViewBuilder
    func makeLabel() -> some View {
        if buttonSize == .large {
            HStack{
                Spacer()
                content
                    .font(.titleSmall)
                Spacer()
                if isIndicate {
                    Image(systemName: "arrow.right")
                        .font(.system(size: 30))
                }
            }
            .frame(width: 300, height: 30)
        } else {
            content
                .font(.bodySmall)
                .frame(width: 85, height: 35)
        }
    }
}
