//
//  AIDiagnosisCard.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/03/12.
//

import SwiftUI

struct AIDiagnosisCard: View {
    
    @Environment(\.presentationMode) var presentationMode
    @State var isMMSEViewPresented = false

    var body: some View {
        VStack(alignment: .leading, spacing: 7) {
            Text("치매 진단 결과")
                .font(.titleMedium)
                .foregroundColor(.mainBlue)
            Text("현재 치매일 가능성이 높습니다")
                .font(.titleSmall)
                .foregroundColor(.mainText)
            Text("AI 진단 결과 치매일 확률이 70%입니다.")
                .font(.bodySmall)
                .foregroundColor(.mainText)
                .lineLimit(nil)
            Text("*AI 진단 정보는 참고용입니다. 정확한 진단은 의사와 상담하세요.")
                .font(.bodyTiny)
                .foregroundColor(.grayTextLight)
          
            Spacer(minLength: 5)
            VStack(alignment: .center) {
                Text("MMSE검사로 정확도 높이기")
                    .font(.bodyMedium)
                    .foregroundColor(.mainBackground)
            }
            .padding(.vertical, 8)
            .frame(maxWidth: .infinity)
            .background(Color.mainBlue)
            .cornerRadius(20)
            .onTapGesture {
                isMMSEViewPresented = true
            }
            
            // MMSE button
            NavigationLink(destination: MMSEView(viewModel: MMSEViewModel(),
                                                 isThisViewPresented: $isMMSEViewPresented),
                           isActive: $isMMSEViewPresented) {
                EmptyView()
            }
//            NavigationLink($isMMSEViewPresented){
//                MMSEView(viewModel: MMSEViewModel())
//            }
        }
        .padding(25)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
        .background(Color.mainBlueLight)
        .cornerRadius(20)
        
    }
}

struct AIDiagnosisCard_Previews: PreviewProvider {
    static var previews: some View {
        AIDiagnosisCard()
    }
}
