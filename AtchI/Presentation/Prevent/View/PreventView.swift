//
//  PreventView.swift
//  AtchI
//
//  Created by 이봄이 on 2023/03/27.
//

import SwiftUI

struct PreventView: View {
    var body: some View {
        VStack {
            ScrollView {
                HStack {
                    Text("예방")
                        .font(.titleLarge)
                    Spacer()
                    
                    Text("퀴즈를 풀며 뇌를 훈련시켜 보세요!")
                        .font(.bodyLarge)
                        .frame(maxWidth: 250, maxHeight: 37)
                        .background(Color.grayBoldLine)
                        
                        .cornerRadius(10)
                        .padding(.vertical, 1)
                }
                .padding(EdgeInsets(top: 10, leading: 30, bottom: 0, trailing: 30))
                
                // 이번주 퀴즈 현황
                QuizStateCard()
                    .padding(EdgeInsets(top: 10, leading: 30, bottom: 0, trailing: 30))
                // 굵은 구분선
                BoldDivider()
                    .padding(.top, 30)
                
                // 제목, 퀴즈 개수 카운트
                VStack {
                    HStack {
                        Text("오늘의 퀴즈")
                            .font(.titleMedium)
                            .foregroundColor(.mainPurple)
                        Spacer()
                        Text("1/3")
                            .font(.titleMedium)
                            .foregroundColor(.mainPurple)
                    }
                    Divider()
                        .padding(.vertical)
                }
                .padding(EdgeInsets(top: 30, leading: 30, bottom: 0, trailing: 30))
                
                VStack {
                    QuizTemplate(quizOrder: "첫", quizCountents: "오늘은 몇월 며칠인가요?")
                        .padding(.bottom, 20)
                    QuizTemplate(quizOrder: "두", quizCountents: "어제 누구랑 점심을 먹었나요?")
                        .padding(.bottom, 20)
                    QuizTemplate(quizOrder: "세", quizCountents: "오늘 아침에 일어나자마자 무엇을 했나요?")
                }
                .padding(.horizontal, 30)
                Spacer()
            }
        }
    }
}

struct PreventView_Previews: PreviewProvider {
    static var previews: some View {
        PreventView()
    }
}
