//
//  SignupViewModel.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/03/31.
//

import Foundation
import Combine

class SignupViewModel: ObservableObject {
    // MARK: - Dependency
    let validationServcie: ValidationService
    let accountService: AccountServiceType
    
    // MARK: - Input State
    @Published var name: String = ""
    @Published var email: String = ""
    @Published var gender: Bool = false
    @Published var birth: String = ""
    @Published var password: String = ""
    @Published var passwordAgain: String = ""
    
    @Subject var tapEmailCertificationButton: Void = ()
    @Subject var tapSignupButton: Void = ()
    
    // MARK: - Ouput State
    /// 이름 형식 검증에 대한 에러 메세지입니다.
    @Published var nameErrorMessage: String = ""
    /// 이메일 형식 검증에 대한 에러 메세지입니다.
    @Published var emailErrorMessage: String = ""
    /// 이메일 인증에 대한 에러 메세지입니다.
    @Published var emailCertificationErrorMessage: String = ""
    // 생년월일 형식에 대한 에러 메세지입니다.
    @Published var birthErrorMessage: String = ""
    /// 비밀번호 형식에 대한 에러 메세지입니다.
    @Published var passwordErrorMessage: String = ""
    /// 비밀번호 확인에 대한 에러 메세지 입니다.
    @Published var passwordAgainErrorMessage: String = ""
    /// 회원가입 성공 여부에 대한 에러 메세지입니다.
    @Published var signupErrorMessage: String = ""
    /// 이메일 인증하기 버튼 비활성화 여부입니다.
    @Published var disabledEmailCertificationField: Bool = false
    /// 회원가입 버튼 비활성화 여부입니다.
    @Published var disableSignupButton: Bool = true
    
    // MARK: - Cancellable Bag
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Constructor
    init(validationServcie: ValidationService,
        accountService: AccountServiceType){
        // TOOD: DI parameter로 바꾸기
        self.accountService = accountService
        self.validationServcie = validationServcie
        self.bind()
    }
    
    // MARK: - Method
    private func bind(){
        // TODO: ✅ onChange에 Validation을 넣는 것 보다 입력을 완료하면 Validation 체크 하는게 좋을까요? 🤔
        // ✔️ weak self를 써야하는지 확인하기
        $name.map {
                self.validationServcie.isValidNameFormat($0)
                || $0.isEmpty
            }.map {
                $0 ? "" : ValidationErrorMessage.invalidName.description
            }.receive(on: RunLoop.main)
            .assign(to: \.nameErrorMessage, on: self)
            .store(in: &cancellables)
        
        $email.map {
                self.validationServcie.isValidEmailFormat($0)
                || $0.isEmpty
            }.map {
                $0 ? "" : ValidationErrorMessage.invalidEmail.description
            }.receive(on: RunLoop.main)
            .assign(to: \.emailErrorMessage, on: self)
            .store(in: &cancellables)
        
        $birth.map {
                self.validationServcie.isValidBirthFormat($0)
                || $0.isEmpty
            }.map {
                $0 ? "" : ValidationErrorMessage.invalidBirth.description
            }.receive(on: RunLoop.main)
            .assign(to: \.birthErrorMessage, on: self)
            .store(in: &cancellables)
        
        $password.map {
                self.validationServcie.isValidPasswordFormat($0)
                || $0.isEmpty
            }.map {
                $0 ? "" : ValidationErrorMessage.invalidPassword.description
            }.receive(on: RunLoop.main)
            .assign(to: \.passwordErrorMessage, on: self)
            .store(in: &cancellables)
        
        $passwordAgain.map {
                $0.isEmpty
            }.map {
                $0 ? "" : ValidationErrorMessage.invalidPasswordAgain.description
            }.receive(on: RunLoop.main)
            .assign(to: \.passwordAgainErrorMessage, on: self)
            .store(in: &cancellables)
        
        $passwordAgain.sink { [self]_ in
            print(self.passwordAgain)
            print(self.password)
        }.store(in: &cancellables)
        
        // signup button enable/disable
        // TODO: 아직 View에 활성화 여부 바인딩 안됨
        $name.combineLatest($email, $password, $passwordAgain) {
            name, email, password, passwordAgain in
            return self.validationServcie.isValidNameFormat(name) ||
            self.validationServcie.isValidEmailFormat(email) ||
            self.validationServcie.isValidPasswordFormat(password) ||
            passwordAgain == password
        }.receive(on: RunLoop.main)
            .assign(to: \.disableSignupButton, on: self)
            .store(in: &cancellables)
        
        
        // SignupButton 누를 시 signup 실행
        $tapSignupButton.sink { [weak self] in
            self?.signup(SignupModel(email: "1234@naver.com",
                                     pw: "1111",
                                     birthday: "010101",
                                     gender: true,
                                     name: "test_1234"))
        }
        .store(in: &cancellables)
        
    }
    
    /// AccountService를 통해 signup api를 실행시키고 결과값을 signupResult로 send함
    /// 근데 이 자체로 Testable 했으면 좋겠는데... -> 불가능한가? -> 그런듯
    func signup(_ signupModel: SignupModel){
        accountService.requestSignup(signupModel: signupModel)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .finished:
                    // 이벤트 완료시 행동 정의
                    break
                case .failure(let error):
                    // 에러 발생시 각각 대응
                    switch error {
                    case .signupFailed:
                        self?.signupErrorMessage = error.krDescription()
                        break
                    case .emailDuplicated:
                        self?.signupErrorMessage = error.krDescription()
                        break
                    default:
                        break
                    }
                    break
                }
            }, receiveValue: { [weak self] result in
                // 성공 시 화면 전환
                self?.signupErrorMessage = ""
            })
            .store(in : &cancellables)
    }
}
