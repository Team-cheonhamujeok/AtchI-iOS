//
//  SignupRequestViewModelType.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/04/29.
//

import Foundation

@available(*, deprecated, message: "뷰모델간의 연결 방식이 Subject 방식으로 바뀌었습니다. Event enum을 참고해주세요")
protocol SignupRequestViewModelType {
    // Input State
    /// 이메일 인증 버튼 탭 이벤트입니다
    var tapSendEmailVerificationButton: Void { get }
    /// 회원가입 버튼 탭 이벤트입니다
    var tapSignupButton: Void { get }
    
    // Output State
    /// 회원가입에 필요한 ViewModel 데이터입니다.
    var signupState: SignupState { get set }
    /// 이메일 인증에 필요한 ViewModel 데이터입니다.
    var emailVerificationState: EmailVerificationState { get set }
}
