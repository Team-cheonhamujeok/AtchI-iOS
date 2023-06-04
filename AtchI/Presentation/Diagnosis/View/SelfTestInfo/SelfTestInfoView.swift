//
//  SelfTestInfoView.swift
//  AtchI
//
//  Created by 강민규 on 2023/03/21.
//

import SwiftUI
import Moya

struct SelfTestInfoView: View {
    @StateObject var viewModel: SelfTestInfoViewModel
    
    @Binding var path: [DiagnosisViewStack]
    
    //MARK: - Body
    
    var body: some View {
        if viewModel.selfTestResults.isEmpty {
            noTestView
        } else {
            haveTestView
        }
    }
    
    //MARK: - 자가진단을 안했을 때
    
    var noTestView: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text("치매 자가진단 해보세요!")
                        .font(.titleMedium)
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 1, trailing: 0))
                    
                    Text("몇가지 질문으로 간단하게 치매 진단을 받아보세요")
                        .font(.bodySmall)
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 3, trailing: 0))
                }
                Spacer()
            }
            .padding(.horizontal, 30)
            
            DefaultButton(buttonSize: .large,
                          buttonStyle: .filled,
                          buttonColor: .accentColor,
                          isIndicate: true)
            {
                path.append(.selfTestStart)
            } content: {
                Text("자가진단 시작하기")
            }
            .padding(25)
        }
    }
    
    //MARK: - 자가진단을 했을 때
    
    var haveTestView: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading) {
                VStack(alignment: .leading) {
                    Text("치매 자가진단 해보세요!")
                        .font(.titleMedium)
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 1, trailing: 0))
                    
                    Text("몇가지 질문으로 간단하게 치매 진단을 받아보세요")
                        .font(.bodySmall)
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 3, trailing: 0))
                }
                DefaultButton(buttonSize: .small,
                              width: 153,
                              height: 35,
                              buttonStyle: .filled,
                              buttonColor: .accentColor,
                              isIndicate: false)
                {
                    path.append(.selfTestStart)
                } content: {
                    Text("자가진단 다시하기")
                }
                .padding(.bottom, 5)
                
                Divider()
            }
            .padding(.horizontal, 30)
            
            // 2️⃣ 자가진단 리스트
            List(viewModel.selfTestResults) { value in
                if let firstID =  viewModel.selfTestResults.first?.id {
                    if firstID == value.id {
                        TestRow(result: value, isFirst: true)
                            .listRowSeparator(.hidden)
                    }
                    else {
                        TestRow(result: value, isFirst: false)
                            .listRowSeparator(.hidden)
                    }
                }
            }
            .scrollDisabled(true)
            .frame(height: 150)
            .listStyle(.plain)
            .padding(.horizontal, 10)
            
            // 3️⃣ 전체보기 버튼
            HStack{
                Spacer()
                DefaultButton(buttonSize: .small,
                              width: 99,
                              height: 35,
                              buttonStyle: .unfilled,
                              buttonColor: .grayDisabled,
                              isIndicate: false)
                {
                    path.append(.selfTestResultList)
                } content: {
                    Text("전체보기")
                }
                Spacer()
            }
            .padding(.bottom, 10)
        }
    }
}

struct DiagnosisViewm_Previews: PreviewProvider {
    static var previews: some View {
        DiagnosisView()
    }
}
