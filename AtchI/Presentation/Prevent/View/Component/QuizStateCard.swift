//
//  QuizStateCard.swift
//  AtchI
//
//  Created by 이봄이 on 2023/03/27.
//

import SwiftUI

struct QuizStateCard: View {
    var days = ["월", "화", "수", "목", "금", "토", "일"]
    var preventViewModel: PreventViewModel
//    var quiz: Quiz
//    var weekQuiz: [Bool]
    var weekQuizState: [WeekQuiz]
    
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
                ForEach(0..<6) { item in
                    ZStack {
//                        if item.quizState! == false {
//                            Circle()
//                                .strokeBorder(Color.mainPurple,lineWidth: 1)
//                                .frame(width: 30, height: 30)
//                        } else if item.quizState! == true {
//                            Circle()
//                                .fill(Color.mainPurple)
//                                .frame(width: 30, height: 30)
//                        }
                        let _ = print("item \(item)")
                        Text(weekQuizState[item].day!)
                            .font(.bodyMedium)
                        
                    }
                    if item != 6 { // match everything but the last
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

//struct QuizStateCard_Previews: PreviewProvider {
//    static var previews: some View {
//        QuizStateCard(preventViewModel: PreventViewModel(quizService: QuizServiceType.self as! QuizServiceType), quiz: <#Quiz#>)
//    }
//}
