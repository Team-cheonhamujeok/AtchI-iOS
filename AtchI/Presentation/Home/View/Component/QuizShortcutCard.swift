//
//  QuizShortcutCard.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/03/13.
//


import SwiftUI

struct QuizShortcutCard: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("퀴즈 풀기")
                .font(.titleMedium)
                .foregroundColor(.mainPurple)
            Group{
                Text("뇌훈련을 통해\n치매 예방학")
                    .font(.bodySmall)
                    .foregroundColor(.mainText)
            }
            Text("바로가기")
                .font(.bodyLarge)
                .foregroundColor(.mainText)
        }
        .padding(30)
        .frame(maxWidth: .infinity,
               maxHeight: .infinity,
               alignment: .leading)
        .background(Color.mainPurpleLight)
        .cornerRadius(20)
        
    }
}

struct QuizShortcutCard_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
