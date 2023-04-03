//
//  LoginViewModel.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/03/31.
//

import Foundation
import Combine


class LoginViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var emailErrorMessage: String = ""
    @Published var passwordErrorMessage: String = ""
    @Published var enableLoginButton: Bool? = false
    
    private var cancellables = Set<AnyCancellable>()
    
    
    init() {
        bind()
    }
    
    func bind() {
        $email.map {
            // 제약조건 검사
            self.isValidEmail(email: $0) || $0.isEmpty
        }
        .sink { [weak self] isValid in
            // 통과 여부에 따라 Error 메세지 띄우기
            if isValid {
                self?.emailErrorMessage = ""
            } else {
                self?.emailErrorMessage =
                    ViewErrorMessage.invalidEmail.krDescription
            }
        }.store(in: &cancellables)

        
        $password.sink { password in
            print("Password changed: \(password)")
        }
        .store(in: &cancellables)
        
        $emailErrorMessage.sink { message in
            print("message changed: \(message)")
        }
        .store(in : &cancellables)
        
        /// email과 password를 통해 버튼 활성화 결정
        $email.combineLatest($password)
                .map { email, password in
                    self.isValidEmail(email: email)
                }
                .receive(on: RunLoop.main)
                .assign(to: \.enableLoginButton, on: self)
                .store(in: &cancellables)
    }
    
    private func isValidEmail(email: String) -> Bool {
        let emailPattern = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailPattern)
        return emailPredicate.evaluate(with: email)
    }
    

    
}
