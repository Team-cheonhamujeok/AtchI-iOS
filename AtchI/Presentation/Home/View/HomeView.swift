//
//  HomeView.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/03/12.
//

import SwiftUI

struct HomeView: View {
    
    @State var richText: String = ""
    
    var body: some View {
        NavigationView {
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
                            Text("현재 활동 정보")
                                .font(.titleSmall)
                            Text("AI 진단에 쓰이고 있는 활동 정보들입니다!")
                                .font(.bodySmall)
                            Spacer(minLength: 10)
                            WatchActivityView()
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
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

