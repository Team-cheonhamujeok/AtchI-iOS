//
//  SignupValidationViewModel.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/04/28.
//

import Foundation
import Combine

protocol SignupValidationViewModelType {
    // Input State
    var name: String { get }
    var email: String { get }
    var gender: Bool { get }
    var birth: String { get }
    var password: String { get }
    var passwordAgain: String { get }
    
    // Output state
    /// 이름 형식 검증에 대한 에러 메세지입니다.
    var nameErrorMessage: String { get }
    /// 이메일 형식 검증에 대한 에러 메세지입니다.
    var emailErrorMessage: String { get }
    /// 이메일 인증에 대한 에러 메세지입니다.
    var emailCertificationErrorMessage: String { get }
    // 생년월일 형식에 대한 에러 메세지입니다.
    var birthErrorMessage: String { get }
    /// 비밀번호 형식에 대한 에러 메세지입니다.
    var passwordErrorMessage: String { get }
    /// 비밀번호 확인에 대한 에러 메세지 입니다.
    var passwordAgainErrorMessage: String { get }
    /// 회원가입 성공 여부에 대한 에러 메세지입니다.
    var signupErrorMessage: String { get }
    /// 회원가입 버튼 비활성화 여부입니다.
    var disableSignupButton: Bool { get }
}

class SignupValidationViewModel: ObservableObject, SignupValidationViewModelType {
    
    // MARK: - Dependency
    let validationServcie: ValidationService
    var requestViewModel: SignupRequestViewModelType? = nil
    
    // MARK: - Input State
    @Published var name: String = ""
    @Published var email: String = ""
    @Published var gender: Bool = false
    @Published var birth: String = ""
    @Published var password: String = ""
    @Published var passwordAgain: String = ""
    
    // MARK: - Ouput State
    @Published var nameErrorMessage: String = ""
    @Published var emailErrorMessage: String = ""
    @Published var emailCertificationErrorMessage: String = ""
    @Published var birthErrorMessage: String = ""
    @Published var passwordErrorMessage: String = ""
    @Published var passwordAgainErrorMessage: String = ""
    @Published var signupErrorMessage: String = ""
    @Published var disableSignupButton: Bool = true
    
    // MARK: - Cancellable Bag
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Constructor
    init(validationServcie: ValidationService){
        self.validationServcie = validationServcie
        self.bind()
    }
    
    // MARK: - Method
    private func bind(){
        
        /// 이름 형식을 검증합니다. 빈 값일 땐 검증하지 않습니다.
        $name.map {
            self.validationServcie.isValidNameFormat($0)
            || $0.isEmpty
        }.map {
            $0 ? "" : ValidationErrorMessage.invalidName.description
        }.receive(on: RunLoop.main)
            .assign(to: \.nameErrorMessage, on: self)
            .store(in: &cancellables)
        
        /// 이메일 형식을 검증합니다. 빈 값일 땐 검증하지 않습니다.
        $email.map {
            self.validationServcie.isValidEmailFormat($0)
            || $0.isEmpty
        }.map {
            $0 ? "" : ValidationErrorMessage.invalidEmail.description
        }.receive(on: RunLoop.main)
            .assign(to: \.emailErrorMessage, on: self)
            .store(in: &cancellables)
        
        /// 생년월일 형식을 검증합니다. 빈 값일 땐 검증하지 않습니다.
        $birth.map {
            self.validationServcie.isValidBirthFormat($0)
            || $0.isEmpty
        }.map {
            $0 ? "" : ValidationErrorMessage.invalidBirth.description
        }.receive(on: RunLoop.main)
            .assign(to: \.birthErrorMessage, on: self)
            .store(in: &cancellables)
        
        /// 비밀번호 형식을 검증합니다. 빈 값일 땐 검증하지 않습니다.
        $password.map {
            self.validationServcie.isValidPasswordFormat($0)
            || $0.isEmpty
        }.map {
            $0 ? "" : ValidationErrorMessage.invalidPassword.description
        }.receive(on: RunLoop.main)
            .assign(to: \.passwordErrorMessage, on: self)
            .store(in: &cancellables)
        
        /// 비밀번호와 다시쓴 비밀번호가 일치하는지 검사합니다. 빈 값일 땐 검증하지 않습니다.
        $passwordAgain.map {
            $0.isEmpty
        }.map {
            $0 ? "" : ValidationErrorMessage.invalidPasswordAgain.description
        }.receive(on: RunLoop.main)
            .assign(to: \.passwordAgainErrorMessage, on: self)
            .store(in: &cancellables)
    }
}
