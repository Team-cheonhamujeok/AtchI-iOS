//
//  DefaultButton.swift
//  AtchI
//
//  Created by 강민규 on 2023/03/19.
//

import SwiftUI

/// 앱에 사용되는 기본 버튼
/// - Parameters:
///     - buttonSize: 버튼의 사이즈에 따른 형태 결정
///     - width : 가로 길이를 커스텀
///     - height : 세로 길이를 커스텀
///     - buttonStyle : Filled or unFilled
///     - buttonColor : 버튼의 색
///     - isIndicate : 방향 지시 아이콘을 넣을 것인가?
///
struct DefaultButton<Content>: View where Content: View {
    let buttonSize: ControlSize
    var width: CGFloat?
    var height: CGFloat?
    let buttonStyle: ButtonStyle
    let buttonColor: Color
    let isIndicate: Bool
 
    
    let action: () -> Void
    @ViewBuilder let content: Content
    
    //MARK: - Body
    var body: some View {
        
        // 버튼 Style에 따른 분기
        switch buttonStyle {
        // 채워진 버튼
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
            
        // 비어있는 버튼
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
                    .font(.titleSmall)
                Spacer()
                
                // Indicate 확인 분기
                if isIndicate {
                    Image(systemName: "arrow.right")
                        .font(.system(size: 30))
                }
            }
            .frame(width: width == nil ? 300 : width,
                   height: height == nil ? 50 : height)
            
        // 그 외는 작은 버튼으로 취급
        default:
            content
                .font(.bodySmall)
                .frame(width: width == nil ? 85 : width,
                       height: height == nil ? 35 : height)
        }
    }
}
