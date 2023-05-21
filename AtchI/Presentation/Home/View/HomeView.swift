//
//  HomeView.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/03/12.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView {
            VStack {
                // 로고 + 앱이름
                AppTitleBar()
                    .padding(.leading, 20)
                    .padding(.top, 5)
                
                ScrollView {
                    // AI 진단 결과 카드
                    Spacer(minLength: 15)
                    VStack(alignment: .leading){
                        Text("AI 진단 결과")
                            .font(.titleMedium)
                        AIDiagnosisCard()
                        
                        Spacer(minLength: 30)
                        Divider()
                        Spacer(minLength: 30)
                        
                        // 애플워치 정보
                        VStack(alignment: .leading, spacing: 10){
                            Text("현재 활동 정보")
                                .font(.titleSmall)
                            Text("AI 진단에 쓰이고 있는 활동 정보들입니다!")
                                .font(.bodySmall)
                            Spacer(minLength: 10)
                            WatchActivityView()
                        }
                    }
                    .padding([.leading, .trailing, .bottom], 30)
                    
                    
                    Rectangle()
                        .frame(height: 15)
                        .foregroundColor(.grayBoldLine)
                    
                    VStack {
                        // 치매 정보 카드 리스트
                        InformationCardList()
                    }
                    .padding(30)
                    
                    // 바닥 여백
                    Spacer(minLength: 40)
                }
            }
            .scrollIndicators(.hidden)
            .frame(maxWidth: .infinity,
                   maxHeight: .infinity,
                   alignment: .leading)
            .background(Color.mainBackground)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

