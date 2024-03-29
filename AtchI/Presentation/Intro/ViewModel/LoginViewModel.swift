//
//  LoginViewModel.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/03/31.
//

import Foundation
import Combine

import Factory

class LoginViewModel: ObservableObject {
    
    // MARK: - Dependency
    
    @Injected(\.accountService) var accountService: AccountServiceType
    @Injected(\.validationService) var validationService: ValidationServiceType
    
    // MARK: - State
    
    /// Action(Event) - 사용자가 발생시키는 이벤트
    @Published var editEmail: String = ""
    @Published var editPassword: String = ""
    @Subject var tapLoginButton: Void = ()
    
    /// Result - 이벤트에 따른 결과
    @Published var emailErrorMessage: String = ""
    @Published var passwordErrorMessage: String = ""
    @Published var loginButtonState: ButtonState = .disabled
    @Published var loginErrorMessage: String = ""
    @Published var showAlert: Bool = false
    
    // MARK: - Cancellable Bag
    
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Constructor
    
    init() {
        bind()
    }
    
    // MARK: - Bind
    
    private func bind() {
        
        $editEmail.map { email in
            // 제약조건 검사
            return self.validationService.isValidEmailFormat(email) || email.isEmpty
        }.map { isValid in
            // 에러 문구 결정
            isValid ? "" : ValidationErrorMessage.invalidEmail.description
        }
        .assign(to: \.emailErrorMessage, on: self)
        .store(in: &cancellables)
        
        // email과 password를 통해 버튼 활성화 결정
        $editEmail.combineLatest($editPassword)
            .map { email, password in
                return self.validationService.isValidEmailFormat(email)
                        && !password.isEmpty
            }
            .map { $0 ? ButtonState.enabled : ButtonState.disabled }
            .receive(on: RunLoop.main)
            .assign(to: \.loginButtonState, on: self)
            .store(in: &cancellables)
        
        // 로그인 요청 보내기
        $tapLoginButton.sink { _ in
            self.reqeustLogin()
            self.loginButtonState = .loading
        }.store(in: &cancellables)
        
    }
    
    // MARK: - Request
    private func reqeustLogin() {
        self.accountService
            .requestLogin(loginModel: LoginRequestModel(id: self.editEmail,
                                                        pw: self.editPassword))
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished: break
                case .failure(let error):
                    self.loginErrorMessage = error.description
                    self.showAlert = true
                    self.loginButtonState = .enabled
                }
            }, receiveValue: { response in
                UserDefaults.standard.set(response.mid, forKey: "mid")
                UserDefaults.standard.set(self.editEmail, forKey: "email")
                
                // Login창 내려가자마자 권한요청 뜨는 UX가 별로라 지연 넣음
                Task.detached {
                    try await Task.sleep(nanoseconds: 1 * 1_000_000_000 / 4)
                    PushNotificationHelper.shared.setAuthorization()
                    HKAuthorizationHelper.shared.setAuthorization()
                }
            }).store(in: &cancellables)
    }
}
