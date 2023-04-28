//
//  SignupView.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/03/16.
//

import SwiftUI
import Combine

struct SignupView: View {
    
    @ObservedObject var validationViewModel: SignupValidationViewModel
    @ObservedObject var requestViewModel: SignupRequestViewModel
    
//    @State var sendedEmailCertification: Bool = false
    
    init() {
        // ViewModel DI
        self.validationViewModel = SignupValidationViewModel(
            validationServcie: ValidationService())
        self.requestViewModel = SignupRequestViewModel(
            accountService: AccountService())
        // 두 뷰모델간 의존성 연결
        self.validationViewModel.requestViewModel = self.requestViewModel
        self.requestViewModel.validationViewModel = self.validationViewModel
    }
    
    var body: some View {
        VStack {
            ScrollView {
                VStack (alignment: .leading, spacing: 20) {
                    // MARK: Page Title
                    Text("회원가입")
                        .font(.titleLarge)
                    
                    // MARK: Input List
                    Spacer(minLength: 15)
                    TextInput(title: "이름",
                              placeholder: "이름을 입력해주세요",
                              text: $validationViewModel.name,
                              errorMessage: $validationViewModel.nameErrorMessage)
                        TextInput(title: "이메일",
                                  placeholder: "예) junjongsul@gmail.com",
                                  text: $validationViewModel.email,
                                  errorMessage: $validationViewModel.emailErrorMessage)
                    VStack {
                        TextInput(title: "이메일 인증",
                                  placeholder: "이메일 인증번호를 입력해주세요",
                                  text: $validationViewModel.email,
                                  errorMessage: $validationViewModel.emailErrorMessage
                        )
                        ThinLightButton(title: requestViewModel.sendedEmailCertification ? "이메일 인증 다시 보내기" : "이메일 인증하기", onTap: requestViewModel.$tapEmailCertificationButton, disabled: $requestViewModel.disabledEmailCertificationField)
                    }
                    ToogleInput(title:"성별",
                                options: ["남", "여"])
                    TextInput(title: "생년월일",
                              placeholder: "8자리 생년월일 ex.230312",
                              text: $validationViewModel.birth,
                              errorMessage: $validationViewModel.birthErrorMessage)
                    SecureInput(title: "비밀번호",
                                placeholder: "비밀번호를 입력해주세요",
                                secureText: $validationViewModel.password,
                                errorMessage: $validationViewModel.passwordErrorMessage)
                    SecureInput(title: "비밀번호 확인",
                                placeholder: "비밀번호를 한번 더 입력해주세요",
                                secureText: $validationViewModel.passwordAgain,
                                errorMessage: $validationViewModel.passwordAgainErrorMessage)
                }
                
                // MARK:  Complete Button
                Spacer(minLength: 20)
                DefaultButton(
                       buttonSize: .large,
                       buttonStyle: .filled,
                       buttonColor: .mainPurple,
                       isIndicate: false,
                       action: {
                           print("회원가입하기 click")
                       },
                       content: {
                           Text("회원가입하기")
                       }
                   )
                Spacer(minLength: 20)
                
                // Already signup
                HStack (alignment: .center, spacing: 3) {
                    Text("이미 가입하셨나요? ")
                        .foregroundColor(.grayTextLight)
                    Text("로그인하기")
                        .foregroundColor(.grayTextLight)
                        .underline()
                        .onTapGesture {
                            // 로그인뷰로 이동이동
                        }
                }
                
                // Bottom margin
                Spacer(minLength: 30)
            }
            .padding(.horizontal, 30)
            .scrollIndicators(.hidden)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onTapGesture {
            hideKeyboard()
        }
    }
    
    
    // This function hides the keyboard when called by sending the 'resignFirstResponder' action to the shared UIApplication.
    private func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
}

struct SingupView_Previews: PreviewProvider {
    static var previews: some View {
        SignupView()
    }
}

