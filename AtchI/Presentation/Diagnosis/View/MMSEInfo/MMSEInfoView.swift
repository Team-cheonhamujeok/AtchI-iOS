//
//  MMSEInfoView.swift
//  AtchI
//
//  Created by 강민규 on 2023/05/25.
//

import SwiftUI

import StackCoordinator

struct MMSEInfoView: View {
    
    @StateObject var viewModel: MMSEInfoViewModel
    var coordinator: BaseCoordinator<DiagnosisLink>
    
    @State var isPresentModal = false
    
    var body: some View {
        Group {
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
        .sheet(isPresented: $isPresentModal) {
            VStack(alignment: .leading) {
                Text("💡 MMSE 검사란?")
                    .font(.titleMedium)
                Text("")
                Text("MMSE 검사는 인지 기능 평가 도구로 인지 손상, 치매 등의 질환을 조기에 발견하기 위한 검사입니다.")
                Text("")
                Text("앱에서는 간략화한 검사를 제공하고 있으며, 보다 정확한 검사는 전문가와 상담하시길 권장드립니다.")
                Text("")
                Text("")
                
                DefaultButton(buttonSize: .large,
                              buttonStyle: .filled,
                              buttonColor: .mainPurpleLight,
                              isIndicate: false)
                {
                    self.isPresentModal = false
                } content: {
                    Text("닫기")
                        .foregroundColor(.mainPurple)
                }
                
            }
            .padding(20)
            .presentationDetents([.height(300)])
        }
    }
    
    //MARK: - Test 안했을 때
    var noTestView: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("간단한 MMSE 검사를 해보세요")
                    .font(.titleMedium)
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 1, trailing: 0))
                Spacer()
            }
            
            Group {
                VStack(alignment: .leading, spacing: 7) {
                    Text("💡 MMSE 검사란?")
                        .font(.titleSmall)
                    VStack (alignment: .leading){
                        Text("MMSE 검사는 인지 기능 평가 도구로 인지 손상, 치매 등의 질환을 조기에 발견하기 위한 검사입니다. 앱에서는 간략화한 검사를 제공하고 있으며, 보다 정확한 검사는 전문가와 상담하시길 권장드립니다.")
                    }
                }
                .frame(maxWidth:.infinity ,alignment: .leading)
                .padding(25)
                .background(Color.grayBoldLine)
                .cornerRadius(20)
            }
            .padding(.vertical, 20)
            
            
            DefaultButton(buttonSize: .large,
                          buttonStyle: .filled,
                          buttonColor: .accentColor,
                          isIndicate: true)
            {
                coordinator.path.append(
                    DiagnosisLink.mmse(
                        BaseCoordinator()
                    )
                )
            } content: {
                Text("MMSE 검사하기")
            }
            
        }
        .padding(.horizontal, 25)
    }
        
    //MARK: - Test 했을 때
    var haveTestView: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading) {
                HStack {
                    Text("간단한 MMSE 검사를 해보세요")
                        .font(.titleMedium)
                    Spacer()
                    Image("question_circle")
                        .foregroundColor(.grayDisabled)
                        .onTapGesture {
                            self.isPresentModal = true
                        }
                }
                DefaultButton(
                    buttonSize: .small,
                    width: 173,
                    height: 35,
                    buttonStyle: .filled,
                    tintColor: .mainPurple,
                    buttonColor: .mainPurpleLight,
                    isIndicate: false
                )
                {
                    coordinator.path.append(
                        DiagnosisLink.mmse(
                            BaseCoordinator()
                        )
                    )
                } content: {
                    Text("MMSE 검사 다시하기")
                        
                }
                .padding(.bottom, 5)
                
                Divider()
            }
            .padding(.horizontal, 30)
            
            // 2️⃣ 자가진단 리스트
            List(viewModel.testResults) { value in
                if let firstID =  viewModel.testResults.first?.id {
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
            .listStyle(.plain)
            .scrollDisabled(true)
            .background(Color.mainBackground)
            .frame(height: 150)
            .padding(.horizontal, 10)
            
            
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
                        DiagnosisLink.mmseInfo(viewModel)
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
