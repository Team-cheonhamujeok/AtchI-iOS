//
//  SelfTestView.swift
//  AtchI
//
//  Created by 강민규 on 2023/03/23.
//

/// 로직 정리
/// - Note :
///    - 문제 답변 클릭 시 보라색으로 변경
///    - 문제 답변 클릭하면 아래에 보라색으로 불 들어옴
///    - 문제 답변 클릭하지 않으면 아래에 Disable 시킴
///
///    - 다음으로 누르면 문제 수 프로그레스 올라감
///    - 애니메이션 이용해서 문제 변경
///    - 마지막 문제 시 완료 버튼으로 변경
///

import SwiftUI
import Moya

struct SelfTestView: View {
    
    @State var buttonSeletor: TestAnswer?
    @ObservedObject var selfTestViewModel: SelfTestViewModel
//    @ObservedObject var selfTestInfoViewModel: SelfTestInfoViewModel
    
    let mid = UserDefaults.standard.integer(forKey: "mid")
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("자가진단")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.horizontal, 30)
                .padding(.bottom, 4)
            
            // 자가진단 설명 뷰
            Text("질문을 보고 10년 전과 비교해서 어떻게 변했는지 선택해주세요.")
                .font(.bodyMedium)
                .padding(.horizontal, 30)
            
            
            VStack {
                Spacer(minLength: 30)
                Group {
                    // Title
                    HStack {
                        Text("문제 수")
                            .font(.titleSmall)
                            .foregroundColor(.mainPurple)
                        Spacer()
                        Text("\(Int(selfTestViewModel.questionIndex + 1)) / 15")
                    }
                    // ProgressView
                    ProgressView(value: selfTestViewModel.questionIndex, total: 14)
                        .progressViewStyle(LinearProgressViewStyle(tint: .mainPurple))
                        .animation(.default, value: selfTestViewModel.questionIndex)
                }
                .padding(.horizontal, 30)
                .padding(.bottom, 10)
                
                // 문제 View
                SelfTestQuestionCardView(buttonSeletor: $buttonSeletor, id: $selfTestViewModel.questionIndex, selfTestViewModel: selfTestViewModel)
                    .padding(.horizontal, 25)
                    .animation(.easeIn, value: selfTestViewModel.questionIndex)
            }
            
            Spacer(minLength: 20)
            
            // 완료 버튼
            DefaultButton(
                buttonSize: .large,
                buttonStyle: .filled,
                buttonColor: buttonSeletor == nil ? .grayDisabled : .accentColor,
                isIndicate: false)
            {
                if buttonSeletor != nil {
                    if selfTestViewModel.questionIndex == 14 {
                        guard let buttonSeletor = buttonSeletor else { return }
                        selfTestViewModel.appendAnswer(testAnswer: buttonSeletor)
                        self.buttonSeletor = nil
                        selfTestViewModel.requestResult(mid: self.mid)
                        selfTestViewModel.goResultPage()
                    } else {
                        guard let buttonSeletor = buttonSeletor else { return }
                        selfTestViewModel.appendAnswer(testAnswer: buttonSeletor)
                        selfTestViewModel.questionIndex += 1
                        self.buttonSeletor = nil
                    }
                }
            } content: {
                if selfTestViewModel.questionIndex == 14 {
                    Text("완료하기")
                        .foregroundColor(.white)
                } else {
                    Text("다음으로")
                        .foregroundColor(.white)
                }
            }
            .disabled(buttonSeletor == nil)
            .padding(.horizontal, 30)
            .padding(.bottom, 30)
        }
    }
}

// MARK: - Reusable Component CardView

struct SelfTestQuestionCardView: View {
    @Binding var buttonSeletor: TestAnswer?
    @Binding var id: Double
    var selfTestViewModel: SelfTestViewModel
    var body: some View {
        VStack {
            VStack(alignment: .leading){
                Text("\(SelfTestQuestions.questions[Int(id)].index)")
                    .padding(.bottom, 7)
                    .foregroundColor(.mainPurple)
                    .fontWeight(.bold)
                HStack {
                    Text("\(SelfTestQuestions.questions[Int(id)].content)")
                    Spacer()
                }
            }
            
            Spacer()
            
            VStack(spacing: 10) {
                DefaultButton(buttonSize: .small,
                              width: .infinity,
                              height: 35,
                              buttonStyle: .filled,
                              buttonColor: buttonSeletor == .never ? .accentColor : .mainPurpleLight,
                              isIndicate: false)
                {
                    if buttonSeletor != .never {
                        buttonSeletor = .never
                    } else {
                        buttonSeletor = nil
                    }
                } content: {
                    Text("변화 없음")
                }
                
                DefaultButton(buttonSize: .small,
                              width: .infinity,
                              height: 35,
                              buttonStyle: .filled,
                              buttonColor: buttonSeletor == .little ? .accentColor : .mainPurpleLight,
                              isIndicate: false)
                {
                    if buttonSeletor != .little {
                        buttonSeletor = .little
                    } else {
                        buttonSeletor = nil
                    }
                } content: {
                    Text("조금 나빠짐")
                }

                DefaultButton(buttonSize: .small,
                              width: .infinity,
                              height: 35,
                              buttonStyle: .filled,
                              buttonColor: buttonSeletor == .many ? .accentColor : .mainPurpleLight,
                              isIndicate: false)
                {
                    if buttonSeletor != .many {
                        buttonSeletor = .many
                    } else {
                        buttonSeletor = nil
                    }
                } content: {
                    Text("많이 나빠짐")
                }
                
                DefaultButton(buttonSize: .small,
                              width: .infinity,
                              height: 35,
                              buttonStyle: .filled,
                              buttonColor: buttonSeletor == .nothing ? .accentColor : .mainPurpleLight,
                              isIndicate: false)
                {
                    if buttonSeletor != .nothing {
                        buttonSeletor = .nothing
                    } else {
                        buttonSeletor = nil
                    }
                } content: {
                    Text("해당 없음")
                }
            }
        }
        .padding(25)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.grayBoldLine)
        .cornerRadius(20)
    }
}

