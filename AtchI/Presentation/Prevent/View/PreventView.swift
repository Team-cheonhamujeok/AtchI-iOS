//
//  PreventView.swift
//  AtchI
//
//  Created by 이봄이 on 2023/03/27.
//

import SwiftUI

struct PreventView: View {
    @StateObject var preventViewModel: PreventViewModel
    @State var viewStack: [QuizStack] = []
    
    var body: some View {
        NavigationStack(path: $viewStack) {
            VStack {
                ScrollView {
                    HStack {
                        Text("예방")
                            .font(.titleLarge)
                        Spacer()
                        
                        //                    Text("퀴즈를 풀며 뇌를 훈련시켜 보세요!")
                        //                        .font(.bodyLarge)
                        //                        .frame(maxWidth: 250, maxHeight: 37)
                        //                        .background(Color.grayBoldLine)
                        //                        .cornerRadius(10)
                        ZStack {
                            Image("speechBubble")
                            Text("퀴즈를 풀며 뇌를 훈련시켜 보세요!")
                                .font(.bodyLarge)
                                .padding(.vertical, 1)
                            
                        }
                        
                    }
                    .padding(EdgeInsets(top: 10, leading: 30, bottom: 0, trailing: 30))
                    
                    // 이번주 퀴즈 현황
                    QuizStateCard()
                        .padding(EdgeInsets(top: 10, leading: 30, bottom: 0, trailing: 30))
                    // 굵은 구분선
                    BoldDivider()
                        .padding(.top, 30)
                    
                    // 제목, 퀴즈 개수 카운트
                    VStack {
                        HStack {
                            Text("오늘의 퀴즈")
                                .font(.titleMedium)
                                .foregroundColor(.mainPurple)
                            Spacer()
                            Text("1/3")
                                .font(.titleMedium)
                                .foregroundColor(.mainPurple)
                        }
                        Divider()
                            .padding(.vertical)
                    }
                    .padding(EdgeInsets(top: 30, leading: 30, bottom: 0, trailing: 30))
                    
                    VStack {
                        QuizTemplate(quizOrder: TodayQuiz.quizzes[0].index, quizContents: TodayQuiz.quizzes[0].content, viewStack: $viewStack, preventViewModel: preventViewModel, quizOrderNumber: 0)
                            .padding(.bottom, 20)
                        QuizTemplate(quizOrder: TodayQuiz.quizzes[1].index, quizContents: TodayQuiz.quizzes[1].content, viewStack: $viewStack, preventViewModel: preventViewModel, quizOrderNumber: 1)
                            .padding(.bottom, 20)
                        QuizTemplate(quizOrder: TodayQuiz.quizzes[2].index, quizContents: TodayQuiz.quizzes[2].content, viewStack: $viewStack, preventViewModel: preventViewModel, quizOrderNumber: 2)
                    }
                    .padding(.horizontal, 30)
                    Spacer()
                } // ScrollView
            } // VStack
                        .navigationDestination(for: QuizStack.self) { value in
                            switch value.identifier {
                            case .quizView:
                                QuizView(quizOrder: value.content.index, quizContent: value.content.content, preventViewModel: preventViewModel, quizPath: $viewStack, quizOrderNumber: value.id)
                            case .quizDoneView:
                                QuizDoneView(quizOrder: value.content.index, preventViewModel: preventViewModel, quizStack: $viewStack)
                            }
                        } // end navigationDestination
        } // NavigationStack
    } // body
    
} // PreventView

struct PreventView_Previews: PreviewProvider {
    static var previews: some View {
        PreventView(preventViewModel: PreventViewModel())
    }
}
