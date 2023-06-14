//
//  SelfTestInfoView.swift
//  AtchI
//
//  Created by 강민규 on 2023/03/21.
//

import SwiftUI
import Moya

import StackCoordinator

struct SelfTestInfoView: View {
    
    @ObservedObject var viewModel: SelfTestInfoViewModel
    
    var coordinator: BaseCoordinator<DiagnosisLink>
    
    //MARK: - Body
    
    var body: some View {
        if viewModel.isLoading || viewModel.isEmpty == nil {
            HStack {
                Spacer()
                LoadingView()
                Spacer()
            }
        } else {
            if viewModel.isEmpty! {
                noTestView
            } else {
                haveTestView
            }
        }
    }
    
    //MARK: - 자가진단을 안했을 때
    
    var noTestView: some View {
        VStack(alignment: .leading) {
            Text("치매 자가진단 해보세요!")
                .font(.titleMedium)
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 1, trailing: 0))
            
            VStack(alignment: .leading) {
                Text("치매 자가진단 기록이 없습니다 🥲")
                    .font(.bodyLarge)
                    .foregroundColor(.mainText)
                    .padding(.bottom, 2)
                
                Group {
                    Text("몇가지 질문으로 간단하게")
                    Text("치매 진단을 받아보세요!")
                }
                .font(.bodyMedium)
                .foregroundColor(.mainText)
                .padding(.bottom, 2)
                
                Text("*서울대학교병원 치매 노화성인지 감퇴증클리닉(02-2072-2451)에서 개발한 검사입니다.")
                    .font(.bodyTiny)
                    .foregroundColor(.grayTextLight)
            }
            .padding(25)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
            .background(Color.mainPurpleLight)
            .cornerRadius(20)
            
            
            DefaultButton(buttonSize: .large,
                          buttonStyle: .filled,
                          buttonColor: .accentColor,
                          isIndicate: true)
            {
                coordinator.path.append(
                    DiagnosisLink.selfTest
                )
            } content: {
                Text("자가진단 시작하기")
            }
            .padding(.vertical, 20)
        }
        .padding(.horizontal, 25)
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
                   coordinator.path.append(
                    DiagnosisLink.selfTest
                   )
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
                            .listRowBackground(Color.clear)
                    }
                    else {
                        TestRow(result: value, isFirst: false)
                            .listRowSeparator(.hidden)
                            .listRowBackground(Color.clear)
                    }
                }
            }
            .scrollDisabled(true)
            .frame(height: 150)
            .listStyle(.plain)
            .padding(.horizontal, 10)
            .background(Color.mainBackground)
            
            // 3️⃣ 전체보기 버튼
            HStack{
                Spacer()
                DefaultButton(buttonSize: .small,
                              width: 99,
                              height: 35,
                              buttonStyle: .unfilled,
                              buttonColor: .grayTextLight,
                              isIndicate: false)
                {
                    viewModel.coordinator.path.append(
                        DiagnosisLink.selfTestInfo(viewModel)
                    )
                } content: {
                    Text("전체보기")
                }
                
                Spacer()
            }
            .padding(.bottom, 10)
        }
        .background(Color.mainBackground)
    }
}

struct DiagnosisViewm_Previews: PreviewProvider {
    static var previews: some View {
        DiagnosisView(
            coordinator: BaseCoordinator<DiagnosisLink>()
        )
    }
}
