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
    @State var tag:Int? = nil
    var preventViewModel: PreventViewModel
    @Binding var quizPath: [QuizStack]
    var quizOrderNumber: Int
    
    var body: some View {
        ZStack{
            Color.mainPurple.ignoresSafeArea()
            VStack(alignment: .leading, spacing: 10) {
                Text(quizOrder + "번째 퀴즈")
                    .font(.titleSmall)
                    .foregroundColor(.white)
                Text(quizContent)
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
                    quizPath.append(QuizStack(id: 0, identifier: .quizDoneView, content: TodayQuiz.quizzes[quizOrderNumber]))
                }, content: {
                    Text("완료")
                        .foregroundColor(.mainPurple)
                })
                .padding(.horizontal, 30)
            }
        }
        .onAppear {
            print("QuizView onAppear\(quizOrder)") //여기서는 첫번째 값으로만 넘어옴..
        }
        
        
    }
}

//struct QuizView_Previews: PreviewProvider {
//    static var previews: some View {
//        QuizView(quizOrder: "첫", quizContent: "오늘 점심은 무엇인가요?", preventViewModel: PreventViewModel(), quizPath: .constant([]))
//    }
//}
