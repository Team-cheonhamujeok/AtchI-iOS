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
                
                ScrollView {
                    // AI 진단 결과 카드
                    Spacer(minLength: 30)
                    VStack(alignment: .leading){
                        Text("AI 진단 결과")
                            .font(.titleMedium)
                        AIDiagnosisCard()
                            .onTapGesture {
                                PushNotificationHelper.shared.pushImmediateNotification(title: "안녕하세요", body: "푸시 알림 테스트입니다.", seconds: 0.1, identifier: "PUSH_TEST")
                            }
                    }
                    
                    // 바로가기 카드
                    Spacer(minLength: 50)
                    VStack(alignment: .leading){
                        Text("바로가기")
                            .font(.titleMedium)
                        HStack{
                            SelfDiagnosisShortcutCard()
                            QuizShortcutCard()
                        }
                    }
                    
                    // 치매 정보 카드 리스트
                    Spacer(minLength: 50)
                    InformationCardList()
                    
                    // 바닥 여백
                    Spacer(minLength: 40)
                }
            }
            .scrollIndicators(.hidden)
            .padding(.horizontal, 30)
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

