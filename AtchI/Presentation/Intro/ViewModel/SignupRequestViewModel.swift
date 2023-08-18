//
//  SignupRequestViewModel.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/04/28.
//

import Foundation
import Combine

import Factory

class SignupRequestViewModel: ObservableObject {
    // MARK: - Dependency
    @Injected(\.accountService) var accountService: AccountServiceType
    var eventToValidationViewModel = PassthroughSubject<SignupRequestViewModelEvent, Never>()
    var eventFromValidationViewModel: PassthroughSubject<SignupValidationViewModelEvent, Never>? = nil
    
    // MARK: - Input State
    @Subject var tapSendEmailVerificationButton: Void = ()
    @Subject var tapCheckEmailVerificationButton: Void = ()
    @Subject var tapSignupButton: Void = ()
    
    @Published var emailVerificationCode: String = "" // << 프로토콜 추가
    
    // MARK: - Ouput State
    @Published var signupState: SignupState = SignupState()
    @Published var emailVerificationState: EmailVerificationState = EmailVerificationState()
    
    // MARK: - Other Data
    /// 서버에서 받은 이메일 확인 코드입니다.
    private var receivedEmailVerificationCode: String = ""
    /// ValidationViewModel로부터 받은 이메일입니다.
    private var receivedEmail: String = ""
    
    // MARK: - Cancellable Bag
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Constructor
    init(accountService: AccountServiceType){
        self.accountService = accountService
        self.bindState()
        self.bindEvent()
    }
    // MARK: - Bind Method
    private func bindState() {
        
        // 이메일 인증하기 버튼을 누르면 이메일 인증 버튼의 문구를 변경할 수 있도록 sendedEmailVerification을 변경합니다.
        $tapSendEmailVerificationButton.map { true }
            .assign(to: \.emailVerificationState.sendEnable, on: self)
            .store(in: &cancellables)
        
        // 서버로 이메일 인증 메일 전송 요청을 보냅니다.
        $tapSendEmailVerificationButton.sink { [weak self] in
            self?.reqeustEmailVerification(self?.receivedEmail ?? "")
        }
        .store(in: &cancellables)
        
        // 사용자가 입력한 이메일 인증코드와 서버에서 받은 인증코드가 같은지 검사합니다.
        $tapCheckEmailVerificationButton.sink { _ in
            if self.emailVerificationCode == self.receivedEmailVerificationCode {
                self.emailVerificationState.sucess = true
                self.emailVerificationState.sended = false
                self.emailVerificationState.checkEnable = false
            } else {
                self.emailVerificationState.failMessage = "인증코드가 일치하지 않습니다"
            }
        }.store(in: &cancellables)
        
        
        // SignupButton을 탭하면 input 정보를 받아오기 위해 ValidationViewModel에 요청을 보냅니다.
        $tapSignupButton.sink { [weak self] in
            self?.eventToValidationViewModel.send(.signup)
        }
        .store(in: &cancellables)
        

    }
    
    func bindEvent(){
        eventFromValidationViewModel?.sink { [weak self]
            (event: SignupValidationViewModelEvent) in
            guard let self = self else { return }
            switch event {
                
            case .emailValid(let email):
                self.receivedEmail = email
                self.emailVerificationState.sendEnable = true
                break
                
            case .emailInvalid:
                self.emailVerificationState.sendEnable = false
                return
                
            case .allInputValid:
                print("event: allInputValid: \(self.emailVerificationState.sucess)")
                self.signupState.signupButtonState
                    = self.emailVerificationState.sucess
                    ? ButtonState.enabled
                    : ButtonState.disabled
                break
                
            case .sendInfoForSignup(let info):
                let gender: Bool =
                    info.gender == "남"
                self.signupState.signupButtonState = .loading
                self.reqeustSignup(
                    SignupReqeustModel(email: info.email,
                                pw: info.password,
                                birthday: info.birth,
                                gender: gender,
                                name: info.name))
                break
                
            }
        }.store(in: &cancellables)
        
    }
    
    // MARK: - Reqeust Method
    func reqeustEmailVerification(_ email: String) {
        self.accountService
            .requestEmailConfirm(email: email)
            .sink(receiveCompletion: { [weak self] completion in
                guard let self = self else { return }
                switch completion {
                case .finished: break
                case .failure(let error):
                    self.emailVerificationState.failMessage = error.description
                }
            }, receiveValue: { (result: EmailVerificationResponseModel) in
                self.receivedEmailVerificationCode = result.verificationCode
                self.emailVerificationState.sended = true
            }).store(in: &cancellables)
    }
    
    /// AccountService를 통해 signup api를 실행시키고 결과값을 signupResult로 send함
    func reqeustSignup(_ signupModel: SignupReqeustModel){
        accountService.requestSignup(signupModel: signupModel)
            .sink(receiveCompletion: { [weak self] completion in
                guard let self = self else { return }
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self.signupState.failMessage = error.description
                    self.signupState.signupButtonState = .enabled
                    break
                }
            }, receiveValue: { [weak self] result in
                guard let self = self else { return }
                // TODO: 성공시 화면 전환
                self.signupState.failMessage = ""
            })
            .store(in : &cancellables)
    }
}
