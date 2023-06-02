//
//  QuizView.swift
//  AtchI
//
//  Created by 이봄이 on 2023/03/27.
//

import SwiftUI

struct QuizView: View {
    var quiz: Quiz
    var preventViewModel: PreventViewModel
    @Binding var quizPath: [QuizStack]
    
    
    var body: some View {
        ZStack{
            Color.mainPurple.ignoresSafeArea()
            VStack(alignment: .leading, spacing: 10) {
                switch (quiz.index!) {
                case 1:
                    Text("첫번째 퀴즈")
                        .font(.titleSmall)
                        .foregroundColor(.white)
                case 2:
                    Text("두번째 퀴즈")
                        .font(.titleSmall)
                        .foregroundColor(.white)
                case 3:
                    Text("세번째 퀴즈")
                        .font(.titleSmall)
                        .foregroundColor(.white)
                default:
                    Text("퀴즈 없음")
                }
                Text(quiz.content!)
                    .font(.titleLarge)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }.padding(EdgeInsets(top: 0, leading: 30, bottom: 30, trailing: 30))
            
            VStack {
                Text("")
                
                Spacer()
                
                DefaultButton(buttonSize: .large, buttonStyle: .filled, buttonColor: .white, isIndicate: false, action: {
//                    print("퀴즈풀기 완료")
                    preventViewModel.calQuizCount()
                    preventViewModel.checkQuiz(quizNum: quiz.index!)
                    
//                    print(preventViewModel.quizCount)
                    quizPath.append(QuizStack(type: .quizDoneView, data: quiz))
                }, content: {
                    Text("완료")
                        .foregroundColor(.mainPurple)
                })
                .padding(.horizontal, 30)
            }
        }
        
        
    }
}

//struct QuizView_Previews: PreviewProvider {
//    static var previews: some View {
//        QuizView(quizOrder: "첫", quizContent: "오늘 점심은 무엇인가요?")
//    }
//}
