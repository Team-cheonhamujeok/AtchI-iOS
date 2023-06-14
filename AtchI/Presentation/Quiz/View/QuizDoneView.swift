//
//  QuizDoneView.swift
//  AtchI
//
//  Created by 이봄이 on 2023/03/27.
//

import SwiftUI
import Factory

import StackCoordinator

struct QuizDoneView: View {
    
    
    var quizOrder: Int
    var solvedQuizCount: Int
    
    var coordinator: BaseCoordinator<QuizLink>
    
    var body: some View {
        ZStack{
            Color.accentColor.ignoresSafeArea()
            VStack(spacing: 15) {
                Text("🎉")
                    .font(.titleLarge)
                switch (quizOrder) {
                case 1:
                    Text("첫번째 퀴즈 완료")
                        .font(.titleLarge)
                case 2:
                    Text("두번째 퀴즈 완료")
                        .font(.titleLarge)
                case 3:
                    Text("세번째 퀴즈 완료")
                        .font(.titleLarge)
                default:
                    Text("퀴즈 없음")
                }
                Text("이제 오늘 퀴즈는 " + String(3 - solvedQuizCount) + "개가 남았어요 :)")
                    .font(.bodyMedium)
            }
            .foregroundColor(.white)
            VStack {
                Text("")
                Spacer()

                DefaultButton(buttonSize: .large, buttonStyle: .filled, buttonColor: .white, isIndicate: false, action: {
//                    viewModel.requestQuiz()
//                    viewModel.getWeekQuiz()
                    coordinator.path.removeAll()
                }, content: {
                    Text("확인")
                        .foregroundColor(.accentColor)
                })
                .padding(.horizontal, 30)
            }
            
        }
        .setCustomNavigationBarHidden(true)
        
    }
}

//struct QuizDoneView_Previews: PreviewProvider {
//    static var previews: some View {
//        QuizDoneView(quizOrder: "첫")
//    }
//}
