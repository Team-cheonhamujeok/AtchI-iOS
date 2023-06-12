//
//  PreventView.swift
//  AtchI
//
//  Created by 이봄이 on 2023/03/27.
//

import SwiftUI
import Factory

import StackCoordinator

struct PreventView: View {
    @ObservedObject var preventViewModel = Container.shared.preventViewModel.resolve()
    
    var coordinator: BaseCoordinator<PreventLink>
    
    var body: some View {
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
                    let _ = print(preventViewModel.thisWeekQuizState.count)
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
                        QuizTemplate(quiz: preventViewModel.todayQuiz[0], coordinator: coordinator)
                            .padding(.bottom, 20)
                        QuizTemplate(quiz: preventViewModel.todayQuiz[1], coordinator: coordinator)
                            .padding(.bottom, 20)
                        QuizTemplate(quiz: preventViewModel.todayQuiz[2], coordinator: coordinator)
                            .padding(.bottom, 20)
                    }
                    .padding(.horizontal, 30)
                } else {
                    /*@START_MENU_TOKEN@*/EmptyView()/*@END_MENU_TOKEN@*/
                }
                Spacer()
            }
        }
        .onAppear {
            preventViewModel.requestQuiz() // 오늘의 퀴즈 요청
            preventViewModel.getWeekQuiz()
        }
        .padding(.top)
        .background(Color.mainBackground)
    }
    
}

//struct PreventView_Previews: PreviewProvider {
//    static var previews: some View {
//        PreventView(preventViewModel: PreventViewModel())
//    }
//}
