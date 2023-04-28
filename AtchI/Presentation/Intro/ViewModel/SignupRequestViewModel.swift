//
//  SignupRequestViewModel.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/04/28.
//

import Foundation
import Combine

enum EmailVerificationState {
    case unableSend
    case enableSend
    case sended
    case suceess
    case fail
}

class SignupRequestViewModel: ObservableObject, SignupRequestViewModelType {
    // MARK: - Dependency
    let accountService: AccountServiceType
    var validationViewModel: SignupValidationViewModelType? = nil
    
    // MARK: - Input State
    @Subject var tapSendEmailVerificationButton: Void = ()
    @Subject var tapCheckEmailVerificationButton: Void = ()
    @Subject var tapSignupButton: Void = ()
    
    @Published var emailVerificationCode: String = "" // << 프로토콜 추가
    
    // MARK: - Ouput State
    @Published var disabledEmailVerificationField: Bool = false
    @Published var sendedEmailVerification: Bool = false
    @Published var emailVerificationErrorMessage: String = ""
    @Published var successEmailVerification: Bool = true
    @Published var signupErrorMessage: String = ""
    @Published var disableSignupButton: Bool = true
    
    // 실험 중
    @Published var emailVerificationState: EmailVerificationState = .unableSend
    
    // MARK: - Other Data
    /// 서버에서 받은 이메일 확인 코드입니다.
    private var receivedEmailVerificationCode: String = ""
    
    // MARK: - Cancellable Bag
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Constructor
    init(accountService: AccountService){
        self.accountService = accountService
        self.bind()
    }
    
    private func bind() {
        
        /// 이메일 인증하기 버튼을 누르면 이메일 인증 버튼의 문구를 변경할 수 있도록 sendedEmailVerification을 변경합니다.
        $tapSendEmailVerificationButton.map { true }
        .assign(to: \.sendedEmailVerification, on: self)
        .store(in: &cancellables)
        
        $tapSendEmailVerificationButton.sink { [weak self] in
            guard let self = self else { return }
            self.accountService
                .requestEmailConfirm(email: self.validationViewModel?.email ?? "")
                .sink(receiveCompletion: { completion in
                    switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        // 에러 발생시 각각 대응
                        switch error {
                        case .sendEmailConfirmFailed :
                            self.emailVerificationErrorMessage = error.description
                            break
                        default:
                            break
                        }
                        break
                    }
                }, receiveValue: { (result: EmailVerificationModel) in
                    self.receivedEmailVerificationCode = result.verificationCode
                    self.sendedEmailVerification = true
                    self.emailVerificationState = .sended
                }).store(in: &cancellables)
        }
        .store(in: &cancellables)
        
        /// 사용자가 입력한 이메일 인증코드와 서버에서 받은 인증코드가 같은지 검사합니다.
        $tapCheckEmailVerificationButton.sink { _ in
            if self.emailVerificationCode == self.receivedEmailVerificationCode {
                self.successEmailVerification = true
            } else {
                self.emailVerificationErrorMessage = "인증코드가 일치하지 않습니다"
            }
        }.store(in: &cancellables)
        
        /// SignupButton을 탭하면 signup serivce를 통해 회원가입 요청을 보냅니다.
        $tapSignupButton.sink { [weak self] in
            self?.signup(SignupModel(email: self?.validationViewModel?.email ?? "",
                                     pw: self?.validationViewModel?.password ?? "",
                                     birthday: self?.validationViewModel?.birth ?? "",
                                     gender: self?.validationViewModel?.gender ?? true,
                                     name: self?.validationViewModel?.name ?? ""))
        }
        .store(in: &cancellables)
    }
    
    /// AccountService를 통해 signup api를 실행시키고 결과값을 signupResult로 send함
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
                        self?.signupErrorMessage = error.description
                        break
                    case .emailDuplicated:
                        self?.signupErrorMessage = error.description
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
