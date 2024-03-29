//
//  LoginView.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/03/29.
//

import SwiftUI
import Moya

struct LoginView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @ObservedObject var viewModel: LoginViewModel
    
    init() {
        self.viewModel = LoginViewModel()
    }
    
    var body: some View {
        
        VStack (alignment: .leading, spacing: 15) {
            // Page title
            Text("로그인")
                .font(.titleLarge)
                .padding(.top, 10)
            
            // Input list
            TextInput(title: "이메일",
                      placeholder: "예) junjongsul@gmail.com",
                      text: $viewModel.editEmail,
                      errorMessage: viewModel.emailErrorMessage)
            SecureInput(title: "비밀번호",
                        placeholder: "비밀번호를 입력해주세요",
                        secureText: $viewModel.editPassword,
                        errorMessage: $viewModel.passwordErrorMessage)
            
            VStack(spacing: 20) {
                // Complete Button
                RoundedButton(title: "로그인하기",
                              onTap: viewModel.$tapLoginButton,
                              state: viewModel.loginButtonState)
            }
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 30)
        .background(Color.mainBackground)
        .onTapGesture {
            hideKeyboard()
        }.alert(isPresented: $viewModel.showAlert) {
            Alert(title: Text("로그인 실패"), message: Text(viewModel.loginErrorMessage), dismissButton: .default(Text("확인")))
        }
        .setCustomNavigationBar(
            dismiss: dismiss,
            backgroundColor: .mainBackground)
    }
    
    
    // This function hides the keyboard when called by sending the 'resignFirstResponder' action to the shared UIApplication.
    private func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
}

//struct LoginView_Previews: PreviewProvider {
//    static var previews: some View {
//        LoginView()
//    }
//}

