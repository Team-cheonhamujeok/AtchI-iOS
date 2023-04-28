//
//  SignupRequestViewModel.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/04/28.
//

import Foundation
import Combine

protocol SignupRequestViewModelType {
    // input state
    /// 이메일 인증 버튼 탭 이벤트입니다
    var tapEmailCertificationButton: Void { get }
    /// 회원가입 버튼 탭 이벤트입니다
    var tapSignupButton: Void { get }
    
    // output state
    /// 회원가입 성공 여부에 대한 에러 메세지입니다.
    var signupErrorMessage: String { get }
    /// 이메일 인증하기 버튼 비활성화 여부입니다.
    var disabledEmailCertificationField: Bool { get }
    /// 이메일 인증을 시도했는지 여부입니다.
    var sendedEmailCertification: Bool { get }
    /// 이메일 인증 성공여부입니다.
    var validEmailcertification: Bool { get }
    /// 이메일 인증 실패 메세지입니다.
    var emailcertificationErrorMessage: Bool { get }
    /// 회원가입 버튼 비활성화 여부입니다.
    var disableSignupButton: Bool { get }
}



class SignupRequestViewModel: ObservableObject, SignupRequestViewModelType {
    // MARK: - Dependency
    let accountService: AccountServiceType
    var validationViewModel: SignupValidationViewModelType? = nil
    
    // MARK: - Input State
    @Subject var tapEmailCertificationButton: Void = ()
    @Subject var tapSignupButton: Void = ()
    
    // MARK: - Ouput State
    @Published var signupErrorMessage: String = ""
    @Published var disabledEmailCertificationField: Bool = false
    @Published var sendedEmailCertification: Bool = false
    @Published var validEmailcertification: Bool = true
    @Published var emailcertificationErrorMessage: Bool = false
    @Published var disableSignupButton: Bool = true
    
    // MARK: - Cancellable Bag
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Constructor
    init(accountService: AccountService){
        self.accountService = accountService
        self.bind()
    }
    
    private func bind() {
        
        /// 이메일 인증하기 버튼을 누르면 이메일 인증 버튼의 문구를 변경할 수 있도록 sendedEmailCertification을 변경합니다.
        $tapEmailCertificationButton.map { true }
        .assign(to: \.sendedEmailCertification, on: self)
        .store(in: &cancellables)
        
        // SignupButton 누를 시 signup 실행
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
