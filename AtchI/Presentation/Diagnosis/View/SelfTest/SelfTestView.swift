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

struct SelfTestView: View {
    @StateObject var viewModel: SelfTestViewModel

    @State var buttonSeletor: TestAnswer?
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                Text("자가진단")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.horizontal, 30)
                
                // 자가진단 설명 뷰
                Text("질문을 보고 10년 전과 비교해서 어떻게 변했는지 선택해주세요.")
                    .font(.bodyMedium)
                    .padding(.horizontal, 30)
                
                
                VStack{
                    Spacer(minLength: 30)
                    Group {
                        // Title
                        HStack {
                            Text("문제 수")
                                .font(.titleSmall)
                                .foregroundColor(.mainPurple)
                            Spacer()
                            Text("\(Int(viewModel.questionIndex + 1)) / 15")
                        }
                        
                        // ProgressView
                        ProgressView(value: viewModel.questionIndex, total: 14)
                            .progressViewStyle(LinearProgressViewStyle(tint: .mainPurple))
                            .animation(.default, value: viewModel.questionIndex)

                    }
                    .padding(.horizontal, 30)
                    .padding(.bottom, 30)
                    
                    
                    // 문제 View
                    //TODO: 카드뷰 패딩 넣어서 안움직이게 하기
                    SelfTestQuestionCardView(buttonSeletor: $buttonSeletor, id: $viewModel.questionIndex)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 8)
                        .animation(.easeIn, value: viewModel.questionIndex)
                        
                    
                    Spacer()
                }
                
                
                // 완료 버튼
                HStack{
                    // 왼쪽 공백
                    Spacer()
                    
                    // 완료 버튼
                    DefaultButton(
                        buttonSize: .large,
                        width: .infinity,
                        buttonStyle: .filled,
                        buttonColor: .mainPurple,
                        isIndicate: false)
                    {
                        if buttonSeletor != nil {
                            if viewModel.questionIndex == 14 {
                                // TODO: 완료 결과 데이터 내보내기
                                
                            } else {
                                viewModel.questionIndex += 1
                                buttonSeletor = nil
                            }
                        }
                    } content: {
                        if viewModel.questionIndex == 14 {
                            Text("완료하기")
                        } else {
                            Text("다음으로")
                        }
                    }
                    .disabled(buttonSeletor == nil)
                    .padding(.all, 30)
                    
                    // 오른쪽 공백
                    Spacer()
                }
            }
        }
    }
}

// MARK: - Reusable Component CardView
/// - Parameters:
///     - id : 문제의 번호
///
struct SelfTestQuestionCardView: View {
    @Binding var buttonSeletor: TestAnswer?
    @Binding var id: Double
    var body: some View {
        VStack {
            VStack {
                // 문제
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
                // 버튼 Set
                // TODO: 버튼 액션 넣기
                /// - Note:
                ///     - 초기에 전부 light로 할까요?
                ///     - 선택시 vivid 해지게?
                ///     - 아무것도 안했을땐 연한색으로
                ///     - 버튼 위치 수정
                ///     - 패딩 디테일 고치기
                ///     - 프로그레스 사용해보기
                ///     - Navigation 타이틀, Text로 고치기
                ///
                VStack(spacing: 10) {
                    DefaultButton(buttonSize: .small,
                                  width: 300,
                                  buttonStyle: .filled,
                                  buttonColor: buttonSeletor == .never ? .mainPurple : .mainPurpleLight,
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
                                  width: 300,
                                  buttonStyle: .filled,
                                  buttonColor: buttonSeletor == .little ? .mainPurple : .mainPurpleLight,
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
                                  width: 300,
                                  buttonStyle: .filled,
                                  buttonColor: buttonSeletor == .many ? .mainPurple : .mainPurpleLight,
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
                                  width: 300,
                                  buttonStyle: .filled,
                                  buttonColor: buttonSeletor == .nothing ? .mainPurple : .mainPurpleLight,
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
            .padding(20)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.grayBoldLine)
        .cornerRadius(20)

    }
}

//MARK: - Preview
struct SelfTestView_Previews: PreviewProvider {
    static var previews: some View {
        SelfTestView(viewModel: SelfTestViewModel())
    }
}
