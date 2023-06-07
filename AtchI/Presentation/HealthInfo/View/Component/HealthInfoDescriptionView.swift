//
//  HealthInfoDescriptionView.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/06/02.
//

import SwiftUI

import MarkdownUI

struct HealthInfoDescriptionView: View {
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("🧐️ 어떤 정보를 수집하나요?")
                .font(.titleSmall)
                .foregroundColor(Color.mainText)
                .padding(.bottom, 5)
            Text("엣치는 **하루에 한번** 애플워치와 아이폰을 통해 건강 정보를 수집하고 있어요. 수집하는 정보는 걸음 수, 수면 총 시간, 분당 심박평균, 심박 변이 4가지예요. 수집한 건강 정보는 30~120일 단위로 모아 AI 진단에 사용됩니다!")
                .font(.bodyMedium)
                .foregroundColor(Color.mainText)
                .lineSpacing(5)
                .padding(.vertical, 20)
                .padding(.horizontal, 25)
                .background(Color.mainBackground)
                .cornerRadius(20)
            
            Spacer(minLength: 20)
            
            Text("⌚️ 애플워치가 꼭 필요한가요?")
                .font(.titleSmall)
                .foregroundColor(Color.mainText)
                .padding(.bottom, 5)
            Text("엣치의 AI 모델에서 가장 중요한 정보는 **‘휴식기 심박수'** 입니다! 따라서 애플워치가 있으면 더 정확한 진단을 내릴 수 있어요 ☺️")
                .font(.bodyMedium)
                .foregroundColor(Color.mainText)
                .lineSpacing(5)
                .padding(.vertical, 20)
                .padding(.horizontal, 25)
                .background(Color.mainBackground)
                .cornerRadius(20)
            
        }
        .padding(.vertical, 20)
        .frame(alignment: .center)
    }
    
}

struct HealthInfoDescriptionModalDescriptionModal_Previews: PreviewProvider {
    static var previews: some View {
        HealthInfoDescriptionView()
    }
}
