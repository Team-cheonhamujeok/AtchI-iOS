//
//  QuizView.swift
//  AtchI
//
//  Created by 이봄이 on 2023/03/27.
//

import SwiftUI

import Factory
import StackCoordinator

struct QuizView: View {
    
    @ObservedObject var viewModel = Container.shared.preventViewModel.resolve()
    
    var quiz: Quiz
    var coordinator: BaseCoordinator<QuizLink>
    
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
                
                DefaultButton(buttonSize: .large,
                              buttonStyle: .filled,
                              buttonColor: .white,
                              isIndicate: false,
                              action: {
                    viewModel.calQuizCount()
                    viewModel.checkQuiz(quizNum: quiz.index!)
                    coordinator.path.append(
                        QuizLink.done(
                            order: quiz.index!,
                            solvedQuizCount: viewModel.quizCount,
                            coordinator: coordinator
                        )
                    )
                },
                              content: {
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
