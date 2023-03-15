//
//  IntroView.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/03/16.
//

import SwiftUI

struct IntroView: View {
    
    var body: some View {
        VStack (alignment: .leading, spacing: 20) {
            VStack (alignment: .leading){
                Image("logo_purple")
                
                Text("안녕하세요\n치매 진단 및 예방 솔루션")
                    .font(.titleLarge)
                HStack (spacing: 0) {
                    Text("엣치")
                        .font(.titleLarge)
                        .foregroundColor(.mainPurple)
                    Text("입니다")
                        .font(.titleLarge)
                }
            }
            
            
            
            Text("*AI 진단 정보는 참고용입니다. \n정확한 진단은 의사와 상담하세요.")
                .font(.bodyTiny)
                .foregroundColor(.grayTextLight)
            
            Spacer()
            
            VStack (spacing: 15){
                Button(action: {
                    // 버튼을 눌렀을 때 수행할 액션
                }) {
                    Text("회원가입하기")
                        .font(.titleSmall)
                        .frame(maxWidth: .infinity, minHeight: 65)
                        .background(Color.mainPurple)
                        .foregroundColor(Color.white)
                        .cornerRadius(20)
                }
                
                Text("이미 가입하셨나요? 로그인하기")
                    .font(.bodyMedium)
                    .foregroundColor(.grayTextLight)
                
            }
        }
        .scrollIndicators(.hidden)
        .padding(.horizontal, 30)
        .frame(maxWidth: .infinity,
               maxHeight: .infinity,
               alignment: .leading)
    }
}


struct IntroView_Previews: PreviewProvider {
    static var previews: some View {
        IntroView()
    }
}

