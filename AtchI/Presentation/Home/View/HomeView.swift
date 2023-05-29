//
//  HomeView.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/03/12.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject private var viewModel = HomeViewModel()
    
    @State var richText: String = ""
    @State private var rotationAngle: Double = 0.0
    
    var body: some View {
        VStack {
            // MARK: 로고 + 앱이름
            AppTitleBar()
                .padding(.leading, 20)
                .padding(.top, 5)
            
            ScrollView {
                // MARK: AI 진단 결과 섹션
                Spacer(minLength: 15)
                VStack(alignment: .leading){
                    Text("AI 진단 결과")
                        .font(.titleMedium)
                    AIDiagnosisCard()
                    
                    Divider()
                        .padding(.vertical, 15)
                    
                    // 애플워치 정보
                    VStack(alignment: .leading, spacing: 10){
                        HStack {
                            Text("현재 활동 정보")
                                .font(.titleSmall)
                            Spacer()
                            Image(systemName: "arrow.clockwise")
                                .foregroundColor(.grayDisabled)
                                .rotationEffect(Angle(degrees: rotationAngle))
                                .animation(.easeInOut(duration: 1),
                                           value: rotationAngle)
                                .onTapGesture {
                                    viewModel.$onTapRefreshButton.send(())
                                    withAnimation {
                                        rotationAngle += 360
                                    }
                                }
                        }
                            Text("AI 진단에 쓰이고 있는 활동 정보들입니다!")
                                .font(.bodyMedium)
                            Spacer(minLength: 10)
                            WatchActivityView(stepCount: $viewModel.stepCount,
                                              heartAverage: $viewModel.heartAverage,
                                              sleepTotal: $viewModel.sleepTotal)
                        }
                    }
                    .padding([.leading, .trailing, .bottom], 30)
                    
                    
                    // 중간 보더
                    Rectangle()
                        .frame(height: 15)
                        .foregroundColor(.grayBoldLine)
                    
                    // MARK: 치매 정보 섹션
                    VStack(alignment: .leading, spacing: 20){
                        Text("치매 정보")
                            .font(.titleMedium)
                        InformationCardList()
                    }
                    .padding(30)
                    
                }
            }
            .scrollIndicators(.hidden)
            .frame(maxWidth: .infinity,
                   maxHeight: .infinity,
                   alignment: .leading)
            .background(Color.mainBackground)
            .onAppear {
                viewModel.$viewOnAppear.send(())
            }
        }
    }
    
    struct HomeView_Previews: PreviewProvider {
        static var previews: some View {
            HomeView()
        }
    }
    
