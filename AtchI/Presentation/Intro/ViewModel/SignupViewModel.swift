//
//  SignupViewModel.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/03/31.
//

import Foundation
import Combine

class SignupViewModel: ObservableObject {
    var password = PassthroughSubject<String, Never>()
    var passwordAgain = PassthroughSubject<String, Never>()
    
    let accountService: AccountService
    
    init(){
        // TOOD: DI parameter로 바꾸기
        accountService = AccountService()
        bind()
    }
    
    private func bind(){
        accountService.reqSignup(signupDTO: <#T##SignupDTO#>)
    }
    
    /// 비밀번호 확인 및 제약 조건 검토
    var validatedPassword: AnyPublisher<String?, Never> {
        return password.combineLatest(passwordAgain)
            .map { password, passwordAgain in
                guard password == passwordAgain, password.count > 8 else { return nil }
                return password
            }
            // 새로운 요구사항 추가 시 map을 이용해 처리
            .map { $0 == "password1" ? nil : $0 }
            // publisher를 AnyPublisher로 바꿈
            .eraseToAnyPublisher()
    }
}
