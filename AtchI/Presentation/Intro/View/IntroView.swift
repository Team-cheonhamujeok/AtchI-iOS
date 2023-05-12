//
//  IntroView.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/03/16.
//

import SwiftUI

enum IntroViewType {
    case login, signup
}

struct IntroView: View {
    
    @State var path: [IntroViewType] = []
    
    var body: some View {
        NavigationStack(path: $path) {
            VStack (alignment: .leading, spacing: 20) {
                // 윗여백
                VStack {} .frame(height: 80)
                
                // 로고 및 환영 문구
                VStack (alignment: .leading, spacing: 5){
                    Image("logo_purple")
                    
                    HStack {
                        Text("안녕하세요")
                            .font(.titleLarge)
                        Spacer()
                    }
                    HStack {
                        Text("AI")
                            .font(.titleLarge)
                        Text("치매 진단 및")
                            .font(.titleLarge)
                        
                    }
                    Text("예방 솔루션")
                        .font(.titleLarge)
                    HStack (spacing: 0) {
                        Text("엣치")
                            .font(.titleLarge)
                            .foregroundColor(.mainPurple)
                        Text("입니다")
                            .font(.titleLarge)
                    }
                }
                
                // 주의사항 문구
                Text("*AI 진단 정보는 참고용입니다. \n정확한 진단은 의사와 상담하세요.")
                    .font(.bodyTiny)
                    .foregroundColor(.grayTextLight)
                
                Spacer()
                
                // 회원가입 및 로그인 버튼
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
                            .onTapGesture {
                                path.append(.signup)
                            }
                    }
                    
                    HStack {
                        Text("이미 가입하셨나요? ")
                            .font(.bodyMedium)
                            .foregroundColor(.grayTextLight)
                        Text("로그인하기")
                            .font(.bodyMedium)
                            .foregroundColor(.grayTextLight)
                            .underline()
                            .onTapGesture {
                                path.append(.login)
                            }
                    }
                    
                }
            }
            .scrollIndicators(.hidden)
            .padding(.horizontal, 30)
            .frame(maxWidth: .infinity,
                   maxHeight: .infinity,
                   alignment: .leading)
            // Set navigation destinations
            .navigationDestination(for: IntroViewType.self) { type in
                switch type {
                case .login:
                    LoginView()
                case .signup:
                    SignupView()
                }
            }
            .onAppear {
                print("info \(Bundle.main.infoDictionary?["BACKEND_ENDPOINT"])")
            }
        }
    }
}


struct IntroView_Previews: PreviewProvider {
    static var previews: some View {
        IntroView()
    }
}

