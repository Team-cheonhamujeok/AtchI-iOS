//
//  QuizTemplate.swift
//  AtchI
//
//  Created by 이봄이 on 2023/03/27.
//

import SwiftUI

struct QuizTemplate: View {
    var quizOrder: String
    var quizContents: String
    @State var tag:Int? = nil
    @Binding var viewStack: [QuizViewStack]
    var preventViewModel: PreventViewModel
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 15) {
                Text(quizOrder + "번째 퀴즈")
                    .font(.titleSmall)
                Text(quizContents)
                    .font(.bodyMedium)
                    .lineLimit(1)
                    .truncationMode(.tail)
            }
            Spacer()
            
            
            Text("도전하기").onTapGesture {
                viewStack.append(.quizView)
                print(quizOrder) // 여기서는 똑바로 출력되는데 QuizView를 그릴 때 계속 첫번째 값만 나옴 ..
                print(viewStack)
            }
            .font(.bodySmall)
            .foregroundColor(.white)
            .padding(EdgeInsets(top: 13, leading: 20, bottom: 13, trailing: 20))
            .background(Capsule().fill(Color.mainPurple))
            
            .navigationDestination(for: QuizViewStack.self) { value in
                switch value {
                case .quizView:
                    QuizView(quizOrder: quizOrder, quizContent: quizContents, preventViewModel: preventViewModel, quizPath: $viewStack)
                case .quizDoneView:
                    QuizDoneView(quizOrder: quizOrder, preventViewModel: preventViewModel, quizStack: $viewStack)
                    
                }
            }
            
            
            
        }
    }
}

struct QuizTemplate_Previews: PreviewProvider {
    static var previews: some View {
        QuizTemplate(quizOrder: "첫", quizContents: "오늘 점심은 무엇인가요?", viewStack: .constant([]), preventViewModel: PreventViewModel())
    }
}
