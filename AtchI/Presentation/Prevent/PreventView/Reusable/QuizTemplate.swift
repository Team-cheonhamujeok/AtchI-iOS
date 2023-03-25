//
//  QuizTemplate.swift
//  AtchI
//
//  Created by 이봄이 on 2023/03/20.
//

import SwiftUI

struct QuizTemplate: View {
    var quizOrder: String
    var quizCountents: String
    @State var tag:Int? = nil
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 15) {
                Text(quizOrder + "번째 퀴즈")
                    .font(.titleSmall)
                Text(quizCountents)
                    .font(.bodyMedium)
                    .lineLimit(1)
                    .truncationMode(.tail)
            }
            Spacer()

            NavigationLink(destination: QuizView(quizOrder: quizOrder, quizContent: quizCountents)) {
                Text("도전하기")
                    .font(.bodySmall)
                    .foregroundColor(.white)
                    .padding(EdgeInsets(top: 13, leading: 20, bottom: 13, trailing: 20))
                    .background(Capsule().fill(Color.mainPurple))
            }
//                .opacity(0)
//                Button("도전하기") {
//                    self.tag = 1
//                }
//                .buttonStyle(RoundButton(labelColor: .white, backgroundColor: .mainPurple))
            
            
            
        }
    }
}

struct QuizTemplate_Previews: PreviewProvider {
    static var previews: some View {
        QuizTemplate(quizOrder: "첫", quizCountents: "오늘은 몇월 며칠인가요? 오늘은 몇월 며칠")
    }
}
