//
//  SignupView.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/03/16.
//

import SwiftUI
import Combine
import Moya

struct SignupView: View {
    
    @ObservedObject var validationViewModel: SignupValidationViewModel
    @ObservedObject var requestViewModel: SignupRequestViewModel
    
//    @State var sendedEmailVerification: Bool = false
    
    init() {
        // ViewModel DI
        self.validationViewModel = SignupValidationViewModel(
            validationServcie: ValidationService())
        self.requestViewModel = SignupRequestViewModel(
            accountService: AccountService(provider: MoyaProvider<AccountAPI>()))
        // 두 뷰모델간 의존성 연결
        self.validationViewModel.eventFromRequestViewModel
            = self.requestViewModel.eventToValidationViewModel
        self.requestViewModel.eventFromValidationViewModel
            = self.validationViewModel.eventToRequestViewModel
        // bind 함수 호출
        self.requestViewModel.bindEvent()
        self.validationViewModel.bindEvent()
    }
    
    var body: some View {
        VStack {
            ScrollView {
                VStack (alignment: .leading, spacing: 20) {
                    // MARK: Page Title
                    Text("회원가입")
                        .font(.titleLarge)
                    
                    // MARK: Input List
//                    Spacer(minLength: )
                    TextInput(title: "이름",
                              placeholder: "이름을 입력해주세요",
                              text: $validationViewModel.infoState.name,
                              errorMessage: validationViewModel.infoErrorState.nameErrorMessage)
                    VStack {
                        TextInput(title: "이메일",
                                  placeholder: "예) junjongsul@gmail.com",
                                  text: $validationViewModel.infoState.email,
                                  errorMessage: validationViewModel.infoErrorState.emailErrorMessage,
                                  disabled: requestViewModel.emailVerificationState.sucess)
                        if !requestViewModel.emailVerificationState.sucess {
                            ThinLightButton(title: requestViewModel.emailVerificationState.sended
                                            ? "이메일 인증번호 다시 보내기"
                                            : "이메일 인증번호 보내기",
                                            onTap: requestViewModel.$tapSendEmailVerificationButton,
                                            disabled: !requestViewModel.emailVerificationState.sendEnable)
                        }
                    }
                    VStack {
                        TextInput(title: "이메일 인증",
                                  placeholder: "이메일 인증번호를 입력해주세요",
                                  text: $requestViewModel.emailVerificationCode,
                                  errorMessage: requestViewModel.emailVerificationState.failMessage,
                                  disabled: !requestViewModel.emailVerificationState.sended
                                  || requestViewModel.emailVerificationState.sucess)
                        if requestViewModel.emailVerificationState.sended {
                            ThinLightButton(title: "확인하기",
                                            onTap: requestViewModel.$tapCheckEmailVerificationButton,
                                            disabled: requestViewModel.emailVerificationState.sucess)
                            .alert(isPresented: $requestViewModel.emailVerificationState.sucess) {
                                Alert(title: Text("인증 성공"), message: Text("인증에 성공하였습니다"), dismissButton: .default(Text("OK")))
                            }
                        }
                    }
                    ToogleInput(title:"성별",
                                options: ["남", "여"],
                                selected: $validationViewModel.infoState.gender)
                    TextInput(title: "생년월일",
                              placeholder: "8자리 생년월일 ex.230312",
                              text: $validationViewModel.infoState.birth,
                              errorMessage: validationViewModel.infoErrorState.birthErrorMessage)
                    SecureInput(title: "비밀번호",
                                placeholder: "비밀번호를 입력해주세요",
                                secureText: $validationViewModel.infoState.password,
                                errorMessage: $validationViewModel.infoErrorState.passwordAgainErrorMessage)
                    SecureInput(title: "비밀번호 확인",
                                placeholder: "비밀번호를 한번 더 입력해주세요",
                                secureText: $validationViewModel.infoState.passwordAgain,
                                errorMessage: $validationViewModel.infoErrorState.passwordAgainErrorMessage)
                }
                
                // MARK:  Complete Button
                Spacer(minLength: 20)
                RoundedButton(title: "회원가입하기",
                              onTap: requestViewModel.$tapSignupButton,
                              state: requestViewModel.signupState.signupButtonState)
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

