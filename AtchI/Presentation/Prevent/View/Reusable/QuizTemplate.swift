//
//  QuizTemplate.swift
//  AtchI
//
//  Created by 이봄이 on 2023/03/27.
//

import SwiftUI

import StackCoordinator

struct QuizTemplate: View {
    var quiz: Quiz
    var coordinator: BaseCoordinator<PreventLink>
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 15) {
                switch (quiz.index!) {
                case 1:
                    Text("첫번째 퀴즈")
                        .font(.titleSmall)
                case 2:
                    Text("두번째 퀴즈")
                        .font(.titleSmall)
                case 3:
                    Text("세번째 퀴즈")
                        .font(.titleSmall)
                default:
                    Text("퀴즈 없음")
                }

                Text(quiz.content!)
                    .font(.bodyMedium)
                    .lineLimit(1)
                    .truncationMode(.tail)
            }
            Spacer()
            
            Text("도전하기")
                .onTapGesture {
                    self.coordinator.path.append(PreventLink.quiz(quiz: quiz, coordinate: coordinator))
            }
            .font(.bodySmall)
            .foregroundColor(.white)
            .padding(EdgeInsets(top: 13, leading: 20, bottom: 13, trailing: 20))
            .background(quiz.check! ? Capsule().fill(Color.accentColor) : Capsule().fill(Color.accentColor))
            .disabled(quiz.check! ? true : false)
        
        }
    }
}

//struct QuizTemplate_Previews: PreviewProvider {
//    static var previews: some View {
//        QuizTemplate(quizOrder: "첫", quizCountents: "오늘 점심은 무엇인가요?")
//    }
//}
