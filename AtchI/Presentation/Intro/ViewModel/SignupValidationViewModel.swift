//
//  SignupValidationViewModel.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/04/28.
//

import Foundation
import Combine

class SignupValidationViewModel: ObservableObject, SignupValidationViewModelType {
    
    // MARK: - Dependency
    let validationServcie: ValidationService
    var requestViewModel: SignupRequestViewModelType? = nil
    var eventToRequestViewModel = PassthroughSubject<SignupValidationViewModelEvent, Never>()
    var eventFromRequestViewModel: PassthroughSubject<SignupRequestViewModelEvent, Never>? = nil
    
    // MARK: - Input State
    
    @Published var infoState: InfoState = InfoState()
    
//    @Published var name: String = ""
//    @Published var email: String = ""
//    @Published var gender: String = "남"
//    @Published var birth: String = ""
//    @Published var password: String = ""
//    @Published var passwordAgain: String = ""
    
    // MARK: - Ouput State
    @Published var infoErrorState: InfoErrorState = InfoErrorState()
    
//    @Published var nameErrorMessage: String = ""
//    @Published var emailErrorMessage: String = ""
//    @Published var birthErrorMessage: String = ""
//    @Published var passwordErrorMessage: String = ""
//    @Published var passwordAgainErrorMessage: String = ""
//    @Published var signupErrorMessage: String = ""
//    @Published var disableSignupButton: Bool = true
//
    // MARK: - Cancellable Bag
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Constructor
    init(validationServcie: ValidationService){
        self.validationServcie = validationServcie
        self.bindState()
        self.bindEvent()
    }
    
    // MARK: - Method
    private func bindState(){
        
        $infoState.sink { [weak self] in
            guard let self = self else { return }
            
            // 형식 검사
            let isNameValid = self.validationServcie.isValidNameFormat($0.name)
            let isEmailValid = self.validationServcie.isValidEmailFormat($0.email)
            let isBirthValid = self.validationServcie.isValidBirthFormat($0.birth)
            let isPasswordValid = self.validationServcie.isValidPasswordFormat($0.password)
            let isPasswordAgainValid = $0.password == $0.passwordAgain
            
            if isNameValid && isEmailValid && isBirthValid && isPasswordValid && isPasswordAgainValid {
                // 모든 입력값이 형식검사를 통과했음을 알리기
                self.eventToRequestViewModel.send(.allInputValid)
            }
            
            if isEmailValid {
                self.eventToRequestViewModel.send(.emailValid(email: $0.email))
            } else {
                self.eventToRequestViewModel.send(.emailInvalid)
            }
            
            // 빈 값일때는 에러메세지 X
            infoErrorState.nameErrorMessage = isNameValid || $0.name.isEmpty ? "" : ValidationErrorMessage.invalidName.description
            infoErrorState.emailErrorMessage = isEmailValid || $0.email.isEmpty ? "" : ValidationErrorMessage.invalidEmail.description
            infoErrorState.birthErrorMessage = isBirthValid || $0.birth.isEmpty ? "" : ValidationErrorMessage.invalidBirth.description
            infoErrorState.passwordErrorMessage = isPasswordValid || $0.password.isEmpty ? "" : ValidationErrorMessage.invalidPassword.description
            infoErrorState.passwordAgainErrorMessage = isPasswordAgainValid || $0.passwordAgain.isEmpty ? "" : ValidationErrorMessage.invalidPasswordAgain.description
        }.store(in: &cancellables)
        
        /// 이름 형식을 검증합니다. 빈 값일 땐 검증하지 않습니다.
//        $name.map {
//            self.validationServcie.isValidNameFormat($0)
//            || $0.isEmpty
//        }.map {
//            $0 ? "" : ValidationErrorMessage.invalidName.description
//        }.receive(on: RunLoop.main)
//            .assign(to: \.nameErrorMessage, on: self)
//            .store(in: &cancellables)
//
//        /// 이메일 형식을 검증합니다. 빈 값일 땐 검증하지 않습니다.
//        $email.map {
//            let isValidEmail = self.validationServcie.isValidEmailFormat($0)
//            let isEmpty = $0.isEmpty
//            self.requestViewModel?.emailVerificationState.sendEnable = isValidEmail && !isEmpty
//            return isValidEmail || isEmpty
//        }.map {
//            $0 ? "" : ValidationErrorMessage.invalidEmail.description
//        }.receive(on: RunLoop.main)
//            .assign(to: \.emailErrorMessage, on: self)
//            .store(in: &cancellables)
//
//        /// 생년월일 형식을 검증합니다. 빈 값일 땐 검증하지 않습니다.
//        $birth.map {
//            self.validationServcie.isValidBirthFormat($0)
//            || $0.isEmpty
//        }.map {
//            $0 ? "" : ValidationErrorMessage.invalidBirth.description
//        }.receive(on: RunLoop.main)
//            .assign(to: \.birthErrorMessage, on: self)
//            .store(in: &cancellables)
//
//        /// 비밀번호 형식을 검증합니다. 빈 값일 땐 검증하지 않습니다.
//        $password.map {
//            self.validationServcie.isValidPasswordFormat($0)
//            || $0.isEmpty
//        }.map {
//            $0 ? "" : ValidationErrorMessage.invalidPassword.description
//        }.receive(on: RunLoop.main)
//            .assign(to: \.passwordErrorMessage, on: self)
//            .store(in: &cancellables)
//
//        /// 비밀번호와 다시쓴 비밀번호가 일치하는지 검사합니다. 빈 값일 땐 검증하지 않습니다.
//        $passwordAgain.map {
//            $0.isEmpty
//        }.map {
//            $0 ? "" : ValidationErrorMessage.invalidPasswordAgain.description
//        }.receive(on: RunLoop.main)
//            .assign(to: \.passwordAgainErrorMessage, on: self)
//            .store(in: &cancellables)
//
        /// 모든 형식 검사를 통과하면 SignupButton을 활성화 시킵니다.
    }
    
    func bindEvent() {
        eventFromRequestViewModel?.sink { [weak self] (event: SignupRequestViewModelEvent) in
            guard let self = self else { return }
            switch event {
                
            case .signup:
                self.eventToRequestViewModel.send(.sendInfo(Info: self.infoState))
                break
            }
            
        }.store(in: &cancellables)
    }
}
