//
//  SignupViewModel.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/03/31.
//

import Foundation
import Combine

class SignupViewModel: ObservableObject {
    let accountService: AccountServiceType
    
    // input
    var password = PassthroughSubject<String, Never>()
    var passwordAgain = PassthroughSubject<String, Never>()
    @Subject var tapSignupButton: Void = ()
    
    // output
    @Subject var signupResult: String = ""
    
    private var cancellable = Set<AnyCancellable>()
    
    init(accountService: AccountServiceType){
        // TOOD: DI parameter로 바꾸기
        self.accountService = accountService
        self.bind()
    }
    
    private func bind(){
        $tapSignupButton.sink { [weak self] in
            self?.signup(SignupModel(email: "1234@naver.com",
                                     pw: "1111",
                                     birthday: "010101",
                                     gender: true,
                                     name: "test_1234"))
        }
        .store(in: &cancellable)
    }
    
    func signup(_ signupModel: SignupModel){
        accountService.reqSignup(signupModel: signupModel)
        .sink(receiveCompletion: { completion in
            switch completion {
            case .finished:
                // Publisher가 완료됨 (complete)
                break
            case .failure(let error):
                // Publisher가 오류를 발생시킴 (error)
                self.$signupResult.send("fail")
                break
            }

        }, receiveValue: { result in
            self.$signupResult.send("success")
        })
        .store(in : &cancellable)
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
