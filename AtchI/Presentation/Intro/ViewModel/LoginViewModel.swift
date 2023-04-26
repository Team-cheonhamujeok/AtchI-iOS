//
//  LoginViewModel.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/03/31.
//

import Foundation
import Combine


class LoginViewModel: ObservableObject {
    
    /// Action(Event) - 사용자가 발생시키는 이벤트
    @Published var editEmail: String = ""
    @Published var editPassword: String = ""
    @Subject var tapLoginButton: Void = ()
    
    /// Result - 이벤트에 따른 결과
    @Published var emailErrorMessage: String = ""
    @Published var passwordErrorMessage: String = ""
    @Published var enableLoginButton: Bool? = false
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        bind()
    }
    
    // MARK: - Bind
    
    private func bind() {
        
        $editEmail.map { email in
            // 제약조건 검사
            return self.isValidEmail(email) || email.isEmpty
        }.map { isValid in
            // 에러 문구 결정
            isValid ? "" : ValidationErrorMessage.invalidEmail.description
        }
        .assign(to: \.emailErrorMessage, on: self)
        .store(in: &cancellables)
        
        $editPassword.map {
            // 제약조건 검사
            self.isValidPassword($0) || $0.isEmpty
        }.sink { [weak self] isValid in
            // 통과 여부에 따라 Error 메세지 띄우기
            self?.passwordErrorMessage =
            isValid
            ? ""
            :ValidationErrorMessage.invalidPassword.description
            
        }
        .store(in: &cancellables)
        
        /// email과 password를 통해 버튼 활성화 결정
        $editEmail.combineLatest($editPassword)
            .map { email, password in
                return self.isValidEmail(email) && self.isValidPassword(password)
            }
            .receive(on: RunLoop.main)
            .assign(to: \.enableLoginButton, on: self)
            .store(in: &cancellables)
        
        $tapLoginButton.sink { _ in
            print("로그인 시도")
        }.store(in: &cancellables)
    }
    
    // MARK: - Validation
    private func isValidEmail(_ email: String) -> Bool {
        let emailPattern = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailPattern)
        return emailPredicate.evaluate(with: email)
    }
    
    private func isValidPassword(_ password: String) -> Bool {
        let passwordRegex = "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[$@$!%*#?&])[A-Za-z\\d$@$!%*#?&]{8,}$"
        return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: password)
    }
}
