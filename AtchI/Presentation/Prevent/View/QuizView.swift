//
//  QuizView.swift
//  AtchI
//
//  Created by 이봄이 on 2023/03/27.
//

import SwiftUI

struct QuizView: View {
    var quiz: Quiz
    @State var tag:Int? = nil
    var preventViewModel: PreventViewModel
    @Binding var quizPath: [QuizStack]
    
    var body: some View {
        ZStack{
            Color.mainPurple.ignoresSafeArea()
            VStack(alignment: .leading, spacing: 10) {
                Text(quiz.index + "번째 퀴즈")
                    .font(.titleSmall)
                    .foregroundColor(.white)
                Text(quiz.content)
                    .font(.titleLarge)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }.padding(EdgeInsets(top: 0, leading: 30, bottom: 30, trailing: 30))
            
            VStack {
                Text("")
                
                Spacer()
                
                DefaultButton(buttonSize: .large, buttonStyle: .filled, buttonColor: .white, isIndicate: false, action: {
                    print("퀴즈풀기 완료")
                    self.tag = 1
                    preventViewModel.quizCountUp()
                    print(preventViewModel.quizCount)
                    quizPath.append(QuizStack(type: .quizDoneView, data: quiz))
                }, content: {
                    Text("완료")
                        .foregroundColor(.mainPurple)
                })
                .padding(.horizontal, 30)
            }
        }
        .onAppear {
        }
        
        
    }
}

//struct QuizView_Previews: PreviewProvider {
//    static var previews: some View {
//        QuizView(quizOrder: "첫", quizContent: "오늘 점심은 무엇인가요?", preventViewModel: PreventViewModel(), quizPath: .constant([]))
//    }
//}
