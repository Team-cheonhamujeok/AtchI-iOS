//
//  MMSEResultStack.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/05/30.
//

import SwiftUI

struct MMSEResultStack: View {
    
    let titles = ["시간 지남력", "장소 지남력", "주의 집중 및 계산", "기억 등록 / 기억 회상", "언어(이름 대기)"]
    
    var body: some View {
        VStack(spacing: 20) {
            Text("검사 결과")
                .font(.titleSmall)
            .foregroundColor(.mainText)
            Divider()
                .foregroundColor(.grayThinLine)
            
            ForEach(titles, id: \.self) { title in
                VStack(spacing: 5) {
                    Text(title)
                        .font(.bodyMedium)
                        .fontWeight(.bold)
                        .foregroundColor(.grayTextLight)
                    Text("2/3")
                        .font(.bodyMedium)
                        .fontWeight(.bold)
                        .foregroundColor(.mainPurple)
                }
                .frame(maxWidth: .infinity)
                .padding(15)
                .background(Color.grayBoldLine)
                .cornerRadius(20)
            }
            
        }
    }
}

struct MMSEResultStack_Previews: PreviewProvider {
    static var previews: some View {
        MMSEResultStack()
    }
}
