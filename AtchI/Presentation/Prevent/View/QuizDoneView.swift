//
//  QuizDoneView.swift
//  AtchI
//
//  Created by 이봄이 on 2023/03/27.
//

import SwiftUI

struct QuizDoneView: View {
    var quizOrder: String
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack{
            Color.mainPurple.ignoresSafeArea()
            VStack(spacing: 15) {
                Text("🎉")
                    .font(.titleLarge)
                Text(quizOrder + "번째 퀴즈 완료")
                    .font(.titleLarge)
                Text("이제 오늘 퀴즈는 " + "개가 남았어요 :)")
                    .font(.bodyMedium)

            }
            .foregroundColor(.white)
            VStack {
                Text("")
                Spacer()

                DefaultButton(buttonSize: .large, buttonStyle: .filled, buttonColor: .white, isIndicate: false, action: {
                    print("퀴즈풀기 완료")
//                    self.presentationMode.value.dismiss()
                }, content: {
                    Text("완료")
                        .foregroundColor(.mainPurple)
                })
            }
            
        }
        
    }
}

struct QuizDoneView_Previews: PreviewProvider {
    static var previews: some View {
        QuizDoneView(quizOrder: "첫")
    }
}
