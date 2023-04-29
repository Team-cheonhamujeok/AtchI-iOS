//
//  SignupRequestViewModelType.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/04/29.
//

import Foundation

protocol SignupRequestViewModelType {
    // input state
    /// 이메일 인증 버튼 탭 이벤트입니다
    var tapSendEmailVerificationButton: Void { get }
    /// 회원가입 버튼 탭 이벤트입니다
    var tapSignupButton: Void { get }
    
    // output state
    /// 회원가입에 필요한 ViewModel 데이터입니다.
    var signupState: SignupState { get set }
    /// 이메일 인증에 필요한 ViewModel 데이터입니다.
    var emailVerificationState: EmailVerificationState { get set }
}
