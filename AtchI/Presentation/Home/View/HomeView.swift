//
//  HomeView.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/03/12.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        ScrollView{
            AppTitleBar()
            
            Spacer(minLength: 30)
            VStack(alignment: .leading){
                Text("AI 진단 결과")
                    .font(.titleMedium)
                AIDiagnosisCard()
            }
            
            Spacer(minLength: 50)
            VStack(alignment: .leading){
                Text("바로가기")
                    .font(.titleMedium)
                HStack{
                    SelfDiagnosisShortcutCard()
                    QuizShortcutCard()
                }
            }
            
            Spacer(minLength: 50)
            VStack(alignment: .leading){
                Text("치매 정보")
                    .font(.titleMedium)
                HStack{
                    SelfDiagnosisShortcutCard()
                }
            }
        
            Spacer(minLength: 30)
        }
        .scrollIndicators(.hidden)
        .padding(.horizontal, 30)
        .frame(maxWidth: .infinity,
               maxHeight: .infinity,
               alignment: .leading)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

