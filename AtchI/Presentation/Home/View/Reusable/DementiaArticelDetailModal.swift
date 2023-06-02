//
//  DementiaArticelDetailModal.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/03/14.
//

import SwiftUI

import MarkdownUI

/// 치매 정보 상세페이지 입니다.
///
/// 선택한 치매 정보에 대한 구체적인 내용을 제공합니다.
/// 모달 형식으로 보여지게 됩니다.
///
/// - Parameters:
///    - pictureName : Assets에 저장된 이미지 이름
///    - title: 이미지 제목
///    - content: 이미지 본문
///
struct DementiaArticelDetailModal: View {
    
    @Environment(\.dismiss) var dismiss
    
    var title: String
    var content: String
    var pictureName: String
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                // image
                VStack{
                    Image(pictureName)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(maxWidth: .infinity)
                }.frame(maxWidth: .infinity,
                        maxHeight: 200,
                        alignment: .leading)
                .background(Color.white)
                
                // title
                Spacer(minLength: 60)
                VStack(alignment: .leading, spacing: 10){
                    Text(title)
                        .font(.titleMedium)
                    Markdown(content)
                        .markdownTextStyle(\.code) {
                            FontFamilyVariant(.monospaced)
                            FontSize(.em(1))
                            ForegroundColor(.mainPurple)
                        }
                        .markdownBlockStyle(\.blockquote) { configuration in
                            configuration.label
                                .padding()
                                .markdownTextStyle {
                                    FontCapsVariant(.lowercaseSmallCaps)
                                    FontWeight(.regular)
                                    BackgroundColor(nil)
                                }
                                .overlay(alignment: .leading) {
                                    Rectangle()
                                        .fill(Color.accentColor)
                                        .frame(width: 4)
                                }
                                .background(Color.accentColor.opacity(0.1))
                        }
                }.frame(maxWidth: .infinity,
                        minHeight: 40,
                        alignment: .leading)
                .padding(.horizontal, 25)
                .padding(.vertical, 15)
                
                // 컨텐츠 위로 밀려고 Spacer
                Spacer(minLength: 20)
                
                ModalDismissButton()
                    .onTapGesture {
                        dismiss()
                    }
                    .padding(.horizontal, 30)
            }
            .frame(maxWidth: .infinity,
                   maxHeight: .infinity,
                   alignment: .leading)
            
        }
    }
}
