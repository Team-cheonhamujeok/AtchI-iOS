//
//  SignupViewModel.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/03/31.
//

import Foundation
import Combine

enum SignupValidationErrorMessage {
    case invalidName
    case invalidEmail
    case invalidBirth
    case invalidPassword
    case invalidPasswordAgain
    
    var description: String {
        switch self {
        case .invalidName:
            return "이름 형식이 올바르지 않습니다"
        case .invalidEmail:
            return "이메일 형식이 올바르지 않습니다"
        case .invalidBirth:
            return "6자리 숫자 형식으로 입력해주세요"
        case .invalidPassword:
            return "영문자, 숫자, 특수문자를 포함한 8자리 이상 비밀번호를 입력해주세요"
        case .invalidPasswordAgain:
            return "비밀번호가 일치하지 않습니다"
        }
    }
}

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
        // TODO: onChange에 Validation을 넣는 것 보다 입력을 완료하면 Validation 체크 하는게 좋을까요? 🤔
        $name.map {
                self.validationServcie.isValidNameFormat($0)
                || $0.isEmpty
            }.map {
                $0 ? "" : SignupValidationErrorMessage.invalidName.description
            }.assign(to: \.nameErrorMessage, on: self)
            .store(in: &cancellables)
        
        $email.map {
                self.validationServcie.isValidEmailFormat($0)
                || $0.isEmpty
            }.map {
                $0 ? "" : SignupValidationErrorMessage.invalidEmail.description
            }.assign(to: \.emailErrorMessage, on: self)
            .store(in: &cancellables)
        
        $birth.map {
                self.validationServcie.isValidBirthFormat($0)
                || $0.isEmpty
            }.map {
                $0 ? "" : SignupValidationErrorMessage.invalidBirth.description
            }.assign(to: \.birthErrorMessage, on: self)
            .store(in: &cancellables)
        
        $password.map {
                self.validationServcie.isValidPasswordFormat($0)
                || $0.isEmpty
            }.map {
                $0 ? "" : SignupValidationErrorMessage.invalidPassword.description
            }.assign(to: \.passwordErrorMessage, on: self)
            .store(in: &cancellables)
        
        $passwordAgain.map {
                $0.isEmpty
            }.map {
                $0 ? "" : SignupValidationErrorMessage.invalidPasswordAgain.description
            }.assign(to: \.passwordAgainErrorMessage, on: self)
            .store(in: &cancellables)
        
        $passwordAgain.sink { [self]_ in
            print(self.passwordAgain)
            print(self.password)
        }.store(in: &cancellables)
        
        
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
    
    // MARK: - Validation
    
    /// 비밀번호 확인 및 제약 조건 검토
    var validatedPassword: AnyPublisher<String?, Never> {
        return $password.combineLatest($passwordAgain)
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
