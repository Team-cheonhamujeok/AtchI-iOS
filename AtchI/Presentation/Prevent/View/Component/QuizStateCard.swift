//
//  QuizStateCard.swift
//  AtchI
//
//  Created by 이봄이 on 2023/03/27.
//

import SwiftUI

struct QuizStateCard: View {
    var days = ["월", "화", "수", "목", "금", "토", "일"]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 7) {
            Text("이번주 퀴즈 현황")
                .font(.titleMedium)
            Text("매일매일 퀴즈를 풀어주셨군요 :)")
                .font(.bodySmall)
                .foregroundColor(.mainText)
                .padding(.bottom, 10)
//            HStack(spacing: 20) {
//                ZStack {
//                    Circle()
//                        .fill(Color.mainPurple)
//                        .frame(width: 30, height: 30)
//                    Text("월")
//                        .font(.bodyMedium)
//                        .foregroundColor(.white)
//                }
//
//            }
            
            // 동그라미 겹쳐지는 로직 짜야함..
            // - 풀었고 오늘보다 과거이면 full circle
            // - 안 풀었고 오늘보다 과거이면 회색 글씨
            // - 오늘인데 풀었으면 full circle, 안 풀었으면 border circle
            // - 오늘보다 미래이면 회색 글씨
            
            HStack {
                ForEach(days, id: \.self) { item in
                    ZStack {
                        if item == "월" {
                        Circle()
                            .fill(Color.mainPurple)
                            .frame(width: 30, height: 30)
                        }
                        else if item == "화" {
                            Circle()
                                .strokeBorder(Color.mainPurple,lineWidth: 1)
                                .frame(width: 30, height: 30)
                        }
                        // Spacer 들어갈때 동그라미 있는 곳 없는 곳 간격이 달라져서 투명 원 하나 넣어둠
                        else {
                            Circle()
                                .fill(.clear)
                                .frame(width: 30, height: 30)
                        }
                        Text(item)
                            .font(.bodyMedium)
                        
                    }
                    if item != days.last { // match everything but the last
                        Spacer()
                        
                    }
                    
                }
            }
            .padding(.top, 5)
            
        }
        .padding(25)
        .frame(maxWidth: .infinity, maxHeight: 144, alignment: .leading)
        .background(Color.mainPurpleLight)
        .cornerRadius(20)
        
    }
}

struct QuizStateCard_Previews: PreviewProvider {
    static var previews: some View {
        QuizStateCard()
    }
}
