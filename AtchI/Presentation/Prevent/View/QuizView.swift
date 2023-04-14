//
//  QuizView.swift
//  AtchI
//
//  Created by 이봄이 on 2023/03/27.
//

import SwiftUI

struct QuizView: View {
    @Binding var quizOrder: String
    @Binding var quizContent: String
//    @State var quizCount: Int = 0
    @State var tag:Int? = nil
    @StateObject var preventViewModel: PreventViewModel
    @Binding var rootIsActive: Bool
    
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
                NavigationLink(destination: QuizDoneView(quizOrder: quizOrder, preventViewModel: PreventViewModel(), shouldPopToRootView: self.$rootIsActive), tag: 1, selection: self.$tag) {
                    EmptyView()
                }
                DefaultButton(buttonSize: .large, buttonStyle: .filled, buttonColor: .white, isIndicate: false, action: {
                    print("퀴즈풀기 완료")
                    self.tag = 1
                    preventViewModel.quizCountUp()
                    print(preventViewModel.quizCount)
                    // 뷰모델에 있는 값을 바꿔도 뷰모델 선언할때 0으로 계속 초기화되는데..? 내가 이해를 잘 못했나봐요 아직..
                    
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
//        QuizView(quizOrder: "첫", quizContent: "오늘 점심은 무엇인가요?", preventViewModel: PreventViewModel(), rootIsActive: true)
//    }
//}
