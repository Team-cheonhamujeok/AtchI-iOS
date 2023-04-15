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
        // SignupButton 누를 시 signup 실행
        $tapSignupButton.sink { [weak self] in
            self?.signup(SignupModel(email: "1234@naver.com",
                                     pw: "1111",
                                     birthday: "010101",
                                     gender: true,
                                     name: "test_1234"))
        }
        .store(in: &cancellable)
    }
    
    /// AccountService를 통해 signup api를 실행시키고 결과값을 signupResult로 send함
    /// 근데 이 자체로 Testable 했으면 좋겠는데...
    func signup(_ signupModel: SignupModel){
        accountService.reqSignup(signupModel: signupModel)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .finished:
                    // 이벤트 완료시 행동 정의
                    break
                case .failure(let error):
                    // 에러 발생시 각각 대응
                    switch error {
                    case .signupFailed:
                        self?.$signupResult.send("fail")
                        break
                    default:
                        break
                    }
                    break
                }
            }, receiveValue: { [weak self] result in
                // 성공 시 화면 전환
                self?.$signupResult.send("success")
            })
            .store(in : &cancellable)
    }
    
    // MARK: - Validation
    func isValidEmail(_ email: String) -> Bool {
        let emailPattern = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailPattern)
        return emailPredicate.evaluate(with: email)
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
