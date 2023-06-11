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
    var weekQuizState: [WeekQuiz]
    var todayInt: Int
    
    var body: some View {
        VStack(alignment: .leading, spacing: 7) {
            Text("이번주 퀴즈 현황")
                .font(.titleMedium)
            Text("\(preventViewModel.countDay)일치 퀴즈 풀기 완료 🙂")
                .font(.bodySmall)
                .foregroundColor(.mainText)
                .padding(.bottom, 10)
            
            // - 풀었고 오늘보다 과거이면 full circle
            // - 안 풀었고 오늘보다 과거이면 회색 글씨
            // - 오늘인데 풀었으면 full circle, 안 풀었으면 border circle
            // - 오늘보다 미래이면 회색 글씨
            
            HStack {
                ForEach(0..<7) { item in
                    ZStack {
                        if item < todayInt {
                            if weekQuizState[item].quizState! == false {
                                Circle()
                                    .fill(Color.clear)
                                    .frame(width: 30, height: 30)
                                Text(weekQuizState[item].day!)
                                    .font(.bodyMedium)
                                    .foregroundColor(Color.grayDisabled)
                            } else if weekQuizState[item].quizState! == true {
                                Circle()
                                    .fill(Color.accentColor)
                                    .frame(width: 30, height: 30)
                                Text(weekQuizState[item].day!)
                                    .font(.bodyMedium)
                                    .foregroundColor(Color.white)
                            }
                        } else if item > todayInt {
                            Circle()
                                .fill(Color.clear)
                                .frame(width: 30, height: 30)
                            Text(weekQuizState[item].day!)
                                .font(.bodyMedium)
                                .foregroundColor(Color.grayDisabled)
                        } else if item == todayInt {
                            if weekQuizState[item].quizState! == false {
                                Circle()
                                    .strokeBorder(Color.accentColor,lineWidth: 1)
                                    .frame(width: 30, height: 30)
                                Text(weekQuizState[item].day!)
                                    .font(.bodyMedium)
                            } else {
                                Circle()
                                    .fill(Color.accentColor)
                                    .frame(width: 30, height: 30)
                                Text(weekQuizState[item].day!)
                                    .font(.bodyMedium)
                                    .foregroundColor(Color.white)
                            }
                        }
                        
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
