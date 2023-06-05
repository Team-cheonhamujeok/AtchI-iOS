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
                            Text("퀴즈를 풀며 뇌를 훈련시켜 보세요!")
                                .font(.bodyLarge)
                                .frame(maxWidth: 250, maxHeight: 37)
                                .background(Color.grayBoldLine)
                                .cornerRadius(10)
                                .padding(.horizontal, 1)
                        
                    }
                    .padding(EdgeInsets(top: 10, leading: 30, bottom: 0, trailing: 30))
                    
                    // 이번주 퀴즈 현황
                    if preventViewModel.thisWeekQuizState.count >= 7 {
                        QuizStateCard(preventViewModel: preventViewModel, weekQuizState: preventViewModel.thisWeekQuizState, todayInt: preventViewModel.todayInt)
                            .padding(EdgeInsets(top: 10, leading: 30, bottom: 0, trailing: 30))
                    } else {
                        EmptyView()
                    }
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
                            if preventViewModel.todayQuiz.count >= 3 {
                                Text("\(preventViewModel.quizCount)/3")
                                    .font(.titleMedium)
                                    .foregroundColor(.mainPurple)
                            } else {
                                EmptyView()
                            }
                        }
                        Divider()
                            .padding(.vertical)
                    }
                    .padding(EdgeInsets(top: 30, leading: 30, bottom: 0, trailing: 30))
                    
                    if preventViewModel.todayQuiz.count >= 3 {
                        VStack {
                            QuizTemplate(quiz: preventViewModel.todayQuiz[0], viewStack: $viewStack, preventViewModel: preventViewModel)
                                .padding(.bottom, 20)
                            QuizTemplate(quiz: preventViewModel.todayQuiz[1], viewStack: $viewStack, preventViewModel: preventViewModel)
                                .padding(.bottom, 20)
                            QuizTemplate(quiz: preventViewModel.todayQuiz[2], viewStack: $viewStack, preventViewModel: preventViewModel)
                                .padding(.bottom, 20)
                        }
                        .padding(.horizontal, 30)
                    } else {
                        /*@START_MENU_TOKEN@*/EmptyView()/*@END_MENU_TOKEN@*/
                    }
                    Spacer()
                }
            }
            // navigationDestination 함수의 클로저는 escaping 클로저임
            // 따라서 한번만 등록되어야함
            // 또한 외부 값을 참조하면 안되고 for 타입을 통해 데이터를 전달받아야함
            .navigationDestination(for: QuizStack.self) { value in
                switch value.type {
                case .quizView:
                    QuizView(quiz: value.data, preventViewModel: preventViewModel, quizPath: $viewStack)
                case .quizDoneView:
                    QuizDoneView(quizOrder: value.data.index!, preventViewModel: preventViewModel, quizStack: $viewStack)
                }
            }
            
        }
        .onAppear {
            preventViewModel.requestQuiz() // 오늘의 퀴즈 요청
            preventViewModel.getWeekQuiz()
        }
        .padding(.top)
    }
    
}

//struct PreventView_Previews: PreviewProvider {
//    static var previews: some View {
//        PreventView(preventViewModel: PreventViewModel())
//    }
//}
