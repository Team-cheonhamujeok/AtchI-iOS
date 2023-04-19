
//
//  DefaultButton.swift
//  AtchI
//
//  Created by 강민규 on 2023/03/19.
//

import SwiftUI
import Combine

struct DefaultButton<Content>: View where Content: View {
    let buttonSize: ControlSize
    var width: CGFloat?
    var height: CGFloat?
    let buttonStyle: ButtonStyle
    let buttonColor: Color
    let isIndicate: Bool
//    @Subject? var subject: Void
    var subject: PassthroughSubject<Void, Never>? = nil
    
    
    let action: () -> Void
    @ViewBuilder let content: Content
    
    //MARK: - Body
    var body: some View {
        
        // 버튼 Style에 따른 분기
        switch buttonStyle {
        // 채워진 버튼
        case .filled:
            Button(action: {
                action()
                subject?.send() }) {
                makeLabel()
            }
            .background(buttonColor)
            .tint(.white)
            .cornerRadius(20)
            
            // 비어있는 버튼
        case .unfilled:
            Button(action: action) {
                makeLabel()
            }
            .buttonStyle(.borderless)
            .tint(buttonColor)
            .overlay {
                RoundedRectangle(
                    cornerRadius:
                        buttonSize == ControlSize.large ? 16 : 100)
                .stroke(buttonColor, lineWidth: 2)
            }
        }
    }
    
    //MARK: - 버튼 Label 만드는 함수
    @ViewBuilder
    func makeLabel() -> some View {
        // 버튼 사이즈에 따른 구분
        switch buttonSize {
            
            // 큰 버튼 일 경우
        case .large:
            HStack{
                Spacer()
                content
                    .padding()
                    .font(.titleSmall)
                Spacer()
                
                // Indicate 확인 분기
                if isIndicate {
                    Image(systemName: "arrow.right")
                        .font(.system(size: 30))
                }
            }
            .frame(maxWidth: .infinity,
                   minHeight: 65,
                   maxHeight: 65)
            
            
            // 그 외는 작은 버튼으로 취급
        default:
            content
                .padding(.all, 5)
                .font(.bodySmall)
                .frame(
                    maxWidth: width,
                    maxHeight: height)
        }
    }
}
