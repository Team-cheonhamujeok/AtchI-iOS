//
//  InformationCardList.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/03/14.
//

import SwiftUI

/// 치매 정보 미리보기 카드 리스트입니다.
///
/// 사진과 타이틀, 본문 미리보기를 가진 카드를 여러장 리스트로 출력합니다.
struct InformationCardList: View {
    
    // dy TODO: 이거 allCases할 수 없나?
    let articles: [DementiaArticleModel]
    
    var body: some View {
        VStack(alignment: .leading){
            VStack(spacing: 20) {
                ForEach(articles, id: \.title) {
                    InformationCard(
                        pictureName: $0.imageName,
                        title: $0.title,
                        content: $0.content ?? "오류가 발생했습니다 😓"
                    )
                }
            }
        }
    }
}



