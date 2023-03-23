//
//  SelfTestView.swift
//  AtchI
//
//  Created by 강민규 on 2023/03/21.
//

import SwiftUI

struct SelfTestView: View {
    @StateObject var viewModel: SelfTestViewModel
    
    //MARK: - Body
    var body: some View {
        if viewModel.isTest {
            testView
        } else {
            noTestView
        }
    }
    
    //MARK: - 자가진단을 안했을 때
    var noTestView: some View {
        VStack {
            HStack {
                ExplainTestView()
                Spacer()
            }
            DefaultButton(buttonSize: .large,
                          buttonStyle: .filled,
                          buttonColor: .mainPurple,
                          isIndicate: true)
            {
                //TODO: navigation 추가하기
                print("HI")
            } content: {
                Text("자가진단 시작하기")
            }
        }
    }
    
    //MARK: - 자가진단을 했을 때
    var testView: some View {
        VStack(alignment: .leading) {
            // 1️⃣ 자가진단 다시하기 버튼
            VStack(alignment: .leading) {
                ExplainTestView()
                DefaultButton(buttonSize: .small,
                              buttonStyle: .filled,
                              buttonColor: .mainPurple,
                              isIndicate: false)
                {
                    //TODO: navigation 추가하기
                    print("HI")
                } content: {
                    Text("자가진단 다시하기")
                }
                Divider()
            }
            
            // 2️⃣ 자가진단 리스트
            //TODO: 테이블뷰 넣기, 최대 2개, 전체보기
            List(viewModel.selfTests.indices, id: \.self) { index in
                SelfTestRow(selfTest: viewModel.selfTests[index],
                            index: index)
                    .listRowSeparator(.hidden)
                
            }
            .scrollDisabled(true)
            .frame(height: 150)
            .listStyle(.inset)
            
            // 3️⃣ 전체보기 버튼
            DefaultButton(buttonSize: .small,
                          buttonStyle: .unfilled,
                          buttonColor: .grayDisabled,
                          isIndicate: false)
            {
                //TODO: Navigation 넣기
                print("HI")
            } content: {
                Text("전체보기")
            }
        }
    }
}

//MARK: - Other View
/// 자가진단 설명 Label
struct ExplainTestView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("치매 자가진단 해보세요!")
                .font(.titleMedium)
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
            Text("몇가지 질문으로 간단하게 치매 진단을 받아보세요")
                .font(.bodySmall)
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
        }
    }
}

//MARK: - Preview
struct SelfTestView_Previews: PreviewProvider {
    static var previews: some View {
        SelfTestView(viewModel: SelfTestViewModel())
    }
}
