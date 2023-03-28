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
                
                Button("도전하기") {
                    print("dismiss")
                    dismiss() //PreventView로 가야함.. 수정!!
                }
//                .buttonStyle(RoundButton(labelColor: .mainPurple, backgroundColor: .white))
//                NavigationLink(destination: PreventView()) {
//                    Text("확인")
//                        .font(.bodySmall)
//                        .foregroundColor(Color.mainPurple)
//                        .padding(EdgeInsets(top: 13, leading: 20, bottom: 13, trailing: 20))
//                        .background(Capsule().fill(.white))
//                }
            }
            .foregroundColor(.white)
            
        }
        
    }
}

struct QuizDoneView_Previews: PreviewProvider {
    static var previews: some View {
        QuizDoneView(quizOrder: "첫")
    }
}
