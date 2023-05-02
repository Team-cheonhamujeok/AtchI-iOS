//
//  HomeView.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/03/12.
//

import SwiftUI
import LinkNavigator

struct HomeView: View {
    
    let navigator: LinkNavigatorType
    
    init(navigator: LinkNavigatorType) {
        self.navigator = navigator
    }
    
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
                                .onTapGesture {
                                    navigator
//                                        .setNavigationVisible(false)
                                        .backToLast(path: "tabBar", isAnimated: true)
                                }
                            QuizShortcutCard()
                                .onTapGesture {
                                    navigator
//                                        .setNavigationVisible(true)
                                        .next(paths: ["prevent"],
                                              items: [:],
                                              isAnimated: true)
                                }
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
            .toolbar(.hidden, for: .navigationBar)
        }
    }
}

//struct HomeView_Previews: PreviewProvider {
//    
//    static var previews: some View {
//        HomeView(dependency: AppDependency.shared)
//    }
//}

