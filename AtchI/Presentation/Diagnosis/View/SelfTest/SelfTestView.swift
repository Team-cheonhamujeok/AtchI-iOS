//
//  SelfTestView.swift
//  AtchI
//
//  Created by 강민규 on 2023/03/23.
//

import SwiftUI

struct SelfTestView: View {
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                // 자가진단 설명 뷰
                Group {
                    Text("질문을 보고 10년 전과 비교해서 어떻게 변했는지")
                        .font(.bodySmall)
                    Text("선택해주세요.")
                        .font(.bodySmall)
                }
                .padding(.leading, 18)
                
                // 문제 스크롤 View
                ScrollView {
                    ForEach(0..<15) { id in
                        SelfTestQuestionCardView(id: id)
                            .padding(.horizontal, 20)
                            .padding(.vertical, 8)
                    }
                }
                
                
                // 완료 버튼
                // TODO: 버튼 액션 넣기
                HStack{
                    // 왼쪽 공백
                    Spacer()
                    
                    // 버튼
                    DefaultButton(
                        buttonSize: .large,
                        buttonStyle: .filled,
                        buttonColor: .grayDisabled,
                        isIndicate: false)
                    {
                        // TODO: Navigation 넣기
                        print("IH")
                    } content: {
                        Text("완료하기")
                    }
                    .padding(.top, 30)
                    
                    // 오른쪽 공백
                    Spacer()
                }
            }
            .navigationTitle("자가진단")
        }
    }
}

// MARK: - Reusable Component CardView
/// - Parameters:
///     - id : 문제의 번호
///
struct SelfTestQuestionCardView: View {
    var id: Int
    var body: some View {
        VStack {
            // 문제
            VStack(alignment: .leading){
                Text("\(SelfTestQuestions.questions[id].index)")
                    .padding(.bottom, 7)
                    .foregroundColor(.mainPurple)
                    .fontWeight(.bold)
                HStack {
                    Text("\(SelfTestQuestions.questions[id].content)")
                    Spacer()
                }
            }
            
            // 버튼 Set
            // TODO: 버튼 액션 넣기
            /// - Note:
            ///     - 초기에 전부 light로 할까요?
            ///     - 선택시 vivid 해지게?
            ///     - 아무것도 안했을땐 연한색으로
            ///     - 버튼 위치 수정
            ///     - 패딩 디테일 고치기
            ///     - 프로그레스 사용해보기
            ///     
            VStack(spacing: 10) {
                DefaultButton(buttonSize: .small,
                              width: 300,
                              buttonStyle: .filled,
                              buttonColor: .mainPurple,
                             isIndicate: false)
                {
                   print("HI")
                } content: {
                   Text("변화 없음")
                }
                
                DefaultButton(buttonSize: .small,
                              width: 300,
                              buttonStyle: .filled,
                              buttonColor: .mainPurple,
                             isIndicate: false)
                {
                   print("HI")
                } content: {
                   Text("조금 나빠짐")
                }
                
                DefaultButton(buttonSize: .small,
                              width: 300,
                              buttonStyle: .filled,
                              buttonColor: .mainPurple,
                             isIndicate: false)
                {
                   print("HI")
                } content: {
                   Text("많이 나빠짐")
                }
                
                DefaultButton(buttonSize: .small,
                              width: 300,
                              buttonStyle: .filled,
                              buttonColor: .mainPurple,
                             isIndicate: false)
                {
                   print("HI")
                } content: {
                   Text("해당 없음")
                }
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.all, 25)
        .background(Color.grayBoldLine)
        .cornerRadius(20)

    }
}

//MARK: - Preview
struct SelfTestView_Previews: PreviewProvider {
    static var previews: some View {
        SelfTestView()
    }
}
