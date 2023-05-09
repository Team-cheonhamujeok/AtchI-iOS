//
//  InformationCard.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/03/13.
//

import SwiftUI

/// 치매 정보 카드입니다.
///
/// 이미지, 제목, 본문으로 구성된 미리보기 카드를 제공합니다.
/// 터치하면 상세페이지 모달로 넘어가게됩니다.
///
/// - Parameters:
///    - pictureName : Assets에 저장된 이미지 이름
///    - title: 이미지 제목
///    - content: 이미지 본문
///
struct InformationCard: View {
    var pictureName: String
    var title: String
    var content: String
    
    @State private var showingDetail = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Image Container
            VStack{
                Image(pictureName)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(maxWidth: .infinity)
            }.frame(maxWidth: .infinity,
                    maxHeight: 140,
                    alignment: .leading)
            .background(Color.white)
            
            // Text Container
            VStack(alignment: .leading){
                Text("\(title)")
                    .foregroundColor(.mainText)
                    .font(.titleSmall)
                Spacer()
                Text("\(content)")
                    .foregroundColor(.grayTextLight)
                    .font(.bodySmall)
                    .lineLimit(1)
            }.frame(maxWidth: .infinity,
                    minHeight: 40,
                    alignment: .leading)
            .padding(.horizontal, 25)
            .padding(.vertical, 15)
            .background(Color.mainBackground)
        }
        // style
        .frame(maxWidth: .infinity,
               maxHeight: .infinity,
               alignment: .leading)
        .background(Color.mainPurpleLight)
        .cornerRadius(20)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .strokeBorder(Color.grayThinLine, lineWidth: 1.5)
        )
        // action - show modal
        .onTapGesture {
            self.showingDetail = true
        }
        .sheet(isPresented: $showingDetail){
            InformationDetailModal(
                title: title,
                content: content,
                pictureName: pictureName).presentationDetents([.medium, .large])
            // dy TODO: Button style custom
            Button("닫기") {
                showingDetail = false
            }
        }
    }
}
