//
//  QuizView.swift
//  AtchI
//
//  Created by 이봄이 on 2023/03/27.
//

import SwiftUI

struct QuizView: View {
    var quizOrder: String
    var quizContent: String
    
    var body: some View {
        ZStack{
            Color.mainPurple.ignoresSafeArea()
            VStack {
                VStack(alignment: .leading, spacing: 10) {
                    Text(quizOrder + "번째 퀴즈")
                        .font(.titleSmall)
                        .foregroundColor(.white)
                    Text(quizContent)
                        .font(.titleLarge)
                        .foregroundColor(.white)
                        .frame(idealWidth: .infinity, alignment: .center)
//                        .lineLimit(3)
                }.padding(.horizontal)
                
                NavigationLink(destination: QuizDoneView(quizOrder: quizOrder)) {
                    Text("완료")
                        .font(.bodySmall)
                        .foregroundColor(Color.mainPurple)
                        .padding(EdgeInsets(top: 13, leading: 20, bottom: 13, trailing: 20))
                        .background(Capsule().fill(.white))
                }
            }
        }
        
        
    }
}

struct QuizView_Previews: PreviewProvider {
    static var previews: some View {
        QuizView(quizOrder: "첫", quizContent: "오늘 점심은 무엇인가요?")
    }
}
