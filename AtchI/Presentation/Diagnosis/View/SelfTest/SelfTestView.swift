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

//MARK: - Reusable Component CardView
struct SelfTestQuestionCardView: View {
    var id: Int
    var body: some View {
        VStack {
            // 문제
            VStack(alignment: .leading){
                Text("\(question[id].index)")
                    .padding(.bottom, 6)
                    .foregroundColor(.mainPurple)
                    .fontWeight(.bold)
                HStack {
                    Text("\(question[id].content)")
                    Spacer()
                }
            }
            
            // 버튼 Set
            //TODO: 버튼 액션 넣기
            Group {
                DefaultButton(buttonSize: .small,
                              buttonStyle: .filled,
                              buttonColor: .mainPurple,
                             isIndicate: false)
                {
                   print("HI")
                } content: {
                   Text("변화 없음")
                }
                
                DefaultButton(buttonSize: .small,
                              buttonStyle: .filled,
                              buttonColor: .mainPurple,
                             isIndicate: false)
                {
                   print("HI")
                } content: {
                   Text("조금 나빠짐")
                }
                
                DefaultButton(buttonSize: .small,
                              buttonStyle: .filled,
                              buttonColor: .mainPurple,
                             isIndicate: false)
                {
                   print("HI")
                } content: {
                   Text("많이 나빠짐")
                }
                
                DefaultButton(buttonSize: .small,
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



//MARK: - Test Question Data
var question: [TestQuestion] =
[TestQuestion(index: "첫번째",
              content: "며칠 전에 나누었던 대화 내용을 기억하는 것은 어떻습니까?"),
 TestQuestion(index: "두번째",
              content: "최근에 했던 약속을 기억하는 것은 어떻습니까?"),
 TestQuestion(index: "세번째",
              content: "최근에 주변에서 일어났던 일을 기억하는 것은 어떻습니까?"),
 TestQuestion(index: "네번째",
              content: "가스불이나 전깃불을 켜놓고 끄는 것을 잊어버리는 것은 어떻습니까?"),
 TestQuestion(index: "다섯번째",
              content: "새로 마련한 가전제품이나 기구의 사용법을 익히는 능력은 어떻습니까?"),
 TestQuestion(index: "여섯번째",
              content: "자신의 개인위생을 관리하거나(세수, 목욕 등) 외모를 가꾸는 정도는 어떻습니까?"),
 TestQuestion(index: "일곱번째",
              content: "중요한 제삿날이나 기념일(배우자의 생일, 결혼기념일, 종교행사일 등)을 기억하는 것은 어떻습니까?"),
 TestQuestion(index: "여덟번째",
              content: "거스름돈을 계산하거나, 돈을 정확히 세서 지불하는 것은 어떻습니까?"),
 TestQuestion(index: "아홉번째",
              content: "이야기 도중에 머뭇거리거나 말문이 막히는 것은 어떻습니까?"),
 TestQuestion(index: "열번째",
              content: "이야기 도중에 물건의 이름을 정확히 대는 정도는 어떻습니까?"),
 TestQuestion(index: "열한번째",
              content: "가까운 사람(자식, 손자, 친한 친구 등)의 이름을 기억하는 것은 어떻습니까?"),
 TestQuestion(index: "열두번째",
              content: "가까운 사람에 관한 사항, 즉 사는 곳이나 직업 등을 기억하는 것은 어떻습니까?"),
 TestQuestion(index: "열세번째",
              content: "자신의 주소나 전화번호를 기억하는 것은 어떻습니까?"),
 TestQuestion(index: "열네번째",
              content: "전화, 가스레인지, 텔레비전 등 집안에서 늘 사용하던 기구를 다루는 능력은 어떻습니까?"),
 TestQuestion(index: "열다섯번째",
              content: "어떤 옷을 입고 나갈지, 저녁식사에 무엇을 준비할지 등 일상적인 상황에서 결정을 내리는 능력은 어떻습니까?")
]

//MARK: - Preview
struct SelfTestView_Previews: PreviewProvider {
    static var previews: some View {
        SelfTestView()
    }
}
