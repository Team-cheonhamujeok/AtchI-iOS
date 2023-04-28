//
//  LoginView.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/03/29.
//

import SwiftUI

struct LoginView: View {
    
    @ObservedObject var viewModel: LoginViewModel
    
    init() {
        self.viewModel = LoginViewModel()
    }
    
    var body: some View {
        
        VStack (alignment: .leading, spacing: 15) {
            // Page title
            Text("로그인")
                .font(.titleLarge)
            
            // Input list
            TextInput(title: "이메일",
                      placeholder: "예) junjongsul@gmail.com",
                      text: $viewModel.editEmail,
                      errorMessage: $viewModel.emailErrorMessage)
            SecureInput(title: "비밀번호",
                        placeholder: "비밀번호를 입력해주세요",
                        secureText: $viewModel.editPassword,
                        errorMessage: $viewModel.passwordErrorMessage)
            
            VStack(spacing: 20) {
                // Complete Button
                DefaultButton(
                    buttonSize: .large,
                    buttonStyle: .filled,
                    buttonColor: .mainPurple,
                    isIndicate: false,
                    subject: viewModel.$tapLoginButton,
                    action: {
                    },
                    content: {
                        Text("로그인하기")
                    }
                )
                
                // Already signup
                HStack (alignment: .center, spacing: 3) {
                    Text("계정이 없으신가요? ")
                        .foregroundColor(.grayTextLight)
                    Text("회원가입하기")
                        .foregroundColor(.grayTextLight)
                        .underline()
                        .onTapGesture {
                            // 회원가입뷰로 이동이동
                        }
                }.frame(maxWidth: .infinity)
            }
            

            
            Spacer()
        }
        
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 30)
        .onTapGesture {
            hideKeyboard()
        }
    }
    
    
    // This function hides the keyboard when called by sending the 'resignFirstResponder' action to the shared UIApplication.
    private func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

