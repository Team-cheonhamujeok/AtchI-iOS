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
    /// 회원가입 성공 여부에 대한 에러 메세지입니다.
    var signupErrorMessage: String { get }
    /// 이메일 인증하기 버튼 비활성화 여부입니다.
    var disabledEmailVerificationField: Bool { get }
    /// 이메일 인증을 시도했는지 여부입니다.
    var sendedEmailVerification: Bool { get }
    /// 이메일 인증 성공여부입니다.
    var successEmailVerification: Bool { get }
    /// 이메일 인증 실패 메세지입니다.
    var emailVerificationErrorMessage: String { get }
    /// 회원가입 버튼 비활성화 여부입니다.
    var disableSignupButton: Bool { get }
}
