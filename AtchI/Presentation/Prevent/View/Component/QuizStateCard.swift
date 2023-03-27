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
//                ZStack {
//                    Circle()
//                        .fill(Color.mainPurple)
//                        .frame(width: 30, height: 30)
//                    Text("화")
//                        .font(.bodyMedium)
//                        .foregroundColor(.white)
//                }
//                ZStack {
//                    Circle()
//                        .fill(Color.mainPurple)
//                        .frame(width: 30, height: 30)
//                    Text("수")
//                        .font(.bodyMedium)
//                        .foregroundColor(.white)
//                }
//                ZStack {
//                    Circle()
//                        .fill(Color.mainPurple)
//                        .frame(width: 30, height: 30)
//                    Text("목")
//                        .font(.bodyMedium)
//                        .foregroundColor(.white)
//                }
//                ZStack {
//                    Circle()
//                        .fill(Color.mainPurple)
//                        .frame(width: 30, height: 30)
//                    Text("금")
//                        .font(.bodyMedium)
//                        .foregroundColor(.white)
//                }
//                ZStack {
//                    Circle()
//                        .fill(Color.mainPurple)
//                        .frame(width: 30, height: 30)
//                    Text("토")
//                        .font(.bodyMedium)
//                        .foregroundColor(.white)
//                }
//                ZStack {
//                    Circle()
//                        .fill(Color.mainPurple)
//                        .frame(width: 30, height: 30)
//                    Text("일")
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
                    Text(item)
                        .font(.bodyMedium)
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
