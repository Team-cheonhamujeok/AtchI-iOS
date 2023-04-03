//
//  LoginViewModel.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/03/31.
//

import Foundation
import Combine


class LoginViewModel: ObservableObject {
    // Input
    @Published var email: String = ""
    @Published var password: String = ""
    
    // Event
    @Published var enableLoginButton: Bool? = false
    
    // Result
    @Published var emailErrorMessage: String = ""
    @Published var passwordErrorMessage: String = ""
    
    private var cancellables = Set<AnyCancellable>()
    
    
    init() {
        bindInput()
        bindEvent()
        bindResult()
    }
    
    private func bindInput() {
        $email.map {
            // 제약조건 검사
            self.isValidEmail($0) || $0.isEmpty
        }
        .sink { [weak self] isValid in
            // 통과 여부에 따라 Error 메세지 띄우기
            self?.emailErrorMessage =
                isValid
                ? ""
                : ViewErrorMessage.invalidEmail.krDescription
        }.store(in: &cancellables)
        
        
        $password.map {
            // 제약조건 검사
            self.isValidPassword($0) || $0.isEmpty
        }.sink { [weak self] isValid in
            // 통과 여부에 따라 Error 메세지 띄우기
            self?.passwordErrorMessage =
                isValid
                ? ""
                :ViewErrorMessage.invalidPassword.krDescription
            
        }
        .store(in: &cancellables)
    }
    
    
    private func bindEvent() {
        /// email과 password를 통해 버튼 활성화 결정
        $email.combineLatest($password)
            .map { email, password in
                self.isValidEmail(email)
            }
            .receive(on: RunLoop.main)
            .assign(to: \.enableLoginButton, on: self)
            .store(in: &cancellables)
    }
    
    private func bindResult() {
        
        $emailErrorMessage.sink { message in
            print("message changed: \(message)")
        }
        .store(in : &cancellables)
        
    }
    
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
