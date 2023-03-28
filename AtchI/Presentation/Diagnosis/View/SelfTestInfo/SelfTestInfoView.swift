//
//  SelfTestInfoView.swift
//  AtchI
//
//  Created by 강민규 on 2023/03/21.
//

import SwiftUI

struct SelfTestInfoView: View {
    @StateObject var viewModel: SelfTestInfoViewModel
    @StateObject var selfTestViewModel: SelfTestViewModel
    
    @Binding var path: [DiagnosisViewStack]
    
    //MARK: - Body
    var body: some View {
        Group {
            if viewModel.isTest {
                haveTestView
            } else {
                noTestView
            }
        }
        .navigationDestination(for: DiagnosisViewStack.self) { child in
            switch child {
            case .selfTest:
                SelfTestView(path: $path, selfTestViewModel: selfTestViewModel)
            case .selfTestStart:
                SelfTestStartView(path: $path, selfTestViewModel: selfTestViewModel)
            case .selfTestResult:
                SelfTestResultView(path: $path, selfTestViewModel: selfTestViewModel)
            default:
                Text("잘못된 접근")
            }
            
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
                path.append(.selfTestStart)
            } content: {
                Text("자가진단 시작하기")
            }
        }
    }
    
    //MARK: - 자가진단을 했을 때
    var haveTestView: some View {
        VStack(alignment: .leading) {
            // 1️⃣ 자가진단 다시하기 버튼
            VStack(alignment: .leading) {
                ExplainTestView()
                DefaultButton(buttonSize: .small,
                              width: 140,
                              height: 25,
                              buttonStyle: .filled,
                              buttonColor: .mainPurple,
                              isIndicate: false)
                {
                    path.append(.selfTestStart)
                } content: {
                    Text("자가진단 다시하기")
                }
                .padding(.bottom, 15)
                
                Divider()
            }
            
            // 2️⃣ 자가진단 리스트
            List(viewModel.selfTestResults.indices, id: \.self) { index in
                SelfTestRow(selfTestResult: viewModel.selfTestResults[index],
                            index: index)
                    .listRowSeparator(.hidden)
                
            }
            .scrollDisabled(true)
            .frame(height: 150)
            .listStyle(.inset)
            
            // 3️⃣ 전체보기 버튼
            HStack{
                Spacer()
                DefaultButton(buttonSize: .small,
                              width: 80,
                              height: 23,
                              buttonStyle: .unfilled,
                              buttonColor: .grayDisabled,
                              isIndicate: false)
                {
                    //TODO: Navigation 넣기
                    print("HI")
                } content: {
                    Text("전체보기")
                }
                Spacer()
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
struct SelfTestInfoView_Previews: PreviewProvider {
    static var previews: some View {
        SelfTestInfoView(viewModel: SelfTestInfoViewModel(), selfTestViewModel: SelfTestViewModel() , path: .constant([]))
    }
}
