//
//  HomeView.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/03/12.
//

import SwiftUI

struct HomeView: View {
    @State private var showingDetail = false
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
                    VStack(alignment: .leading){
                        Text("치매 정보")
                            .font(.titleMedium)
                        // TODO: Information Card 추상화, gesture 다시 정리
                        HStack{
                            InformationCard(title: "치매란 무엇인가요", content: "치매란 기억 상실을 동반하는 질환으로 ...", pictureName: "picture1")
                                .onTapGesture {
                                    self.showingDetail = true
                                }
                                .sheet(isPresented: $showingDetail){
                                    InformationDetailModal(title: "--", content: "--", pictureName: "picture1")
                                    Button("Dismiss") {
                                        showingDetail = false
                                    }
                                }
                        }
                    }
                    
                    Spacer(minLength: 30)
                }
            }
            .scrollIndicators(.hidden)
            .padding(.horizontal, 30)
            .frame(maxWidth: .infinity,
                   maxHeight: .infinity,
                   alignment: .leading)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

