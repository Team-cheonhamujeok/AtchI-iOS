//
//  SignupValidationViewModel.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/04/28.
//

import Foundation
import Combine

import Factory

class SignupValidationViewModel: ObservableObject {
    
    // MARK: - Dependency
    @Injected(\.validationService) var validationServcie: ValidationServiceType
    var eventToRequestViewModel = PassthroughSubject<SignupValidationViewModelEvent, Never>()
    var eventFromRequestViewModel: PassthroughSubject<SignupRequestViewModelEvent, Never>? = nil
    
    // MARK: - Input State
    @Published var infoState: InfoState = InfoState()
    
    // MARK: - Ouput State
    @Published var infoErrorState: InfoErrorState = InfoErrorState()
    
    // MARK: - Cancellable Bag
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Constructor
    init(validationServcie: ValidationServiceType){
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
            } else if isEmailValid {
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
        
    }
    
    func bindEvent() {
        eventFromRequestViewModel?.sink { [weak self] (event: SignupRequestViewModelEvent) in
            guard let self = self else { return }
            switch event {
                
            case .signup:
                self.eventToRequestViewModel.send(.sendInfoForSignup(Info: self.infoState))
                break
            }
            
        }.store(in: &cancellables)
    }
}
