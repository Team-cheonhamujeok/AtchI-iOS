//
//  PreventView.swift
//  AtchI
//
//  Created by 이봄이 on 2023/03/19.
//

// - 양쪽 여백 30으로 통일

import SwiftUI

struct PreventView: View {
    var body: some View {

        NavigationStack {
            VStack {
                // 이번주 퀴즈 현황
                QuizStateCard()
                    .padding(EdgeInsets(top: 30, leading: 30, bottom: 0, trailing: 30))
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
                    QuizTemplate(quizOrder: "두", quizCountents: "어제 누구랑 점심을 먹었나요?")
                    QuizTemplate(quizOrder: "세", quizCountents: "오늘 아침에 일어나자마자 무엇을 했나요?")
                }
                
                .padding(.horizontal, 30)
                Spacer()
            }
            .listRowInsets(EdgeInsets())
            .listRowSeparator(.hidden)

            .navigationTitle("예방")
            
        }
        
    }
}

struct PreventView_Previews: PreviewProvider {
    static var previews: some View {
        PreventView()
    }
}
