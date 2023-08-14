//
//  AccountServiceType.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/04/15.
//

import Foundation
import Combine
import Moya

/// 회원가입 관련 API Service입니다.
protocol AccountServiceType {
    /// 인증 코드를 담은 메일을 발송하는 요청을 보냅니다.
    ///
    /// - Parameters:
    ///    - email: String타입의 이메일을 전달합니다.
    /// - Returns: 요청에 성공시 사용자 이메일로 보내진 인증코드를 받습니다. 실패 시 AccountError를 thorw합니다.
    func requestEmailConfirm(email: String) -> AnyPublisher<EmailVerificationResponseModel, AccountError>
    
    /// 회원가입 요청을 보냅니다.
    ///
    /// - Parameters:
    ///    - signupModel: 회원가입에 필요한 정보들을 담은 Model입니다.
    /// - Returns: 요청에 성공시 SignupResponseModel을 반환합니다. 실패 시 AccountError를 반환합니다.
    func requestSignup(signupModel: SignupReqeustModel) -> AnyPublisher<SignupResponseModel, AccountError>
    
    /// 로그인 요청을 보냅니다.
    ///
    /// - Parameters:
    ///    - loginModel: 로그인에 필요한 정보들을 담은 Model입니다.
    /// - Returns: 요청에 성공시 LoginResponseModel을 반환합니다. 실패 시 AccountError를 반환합니다.
    func requestLogin(loginModel: LoginRequestModel) -> AnyPublisher<LoginResponseModel, AccountError>
    
    /// 회원 탈퇴 요청을 보냅니다.
    ///
    /// - Parameters:
    ///    - email: String타입의 이메일을 전달합니다.
    /// - Returns: 요청에 성공시 CancelMembershipResponseModel을 반환합니다. 실패 시 AccountError를 반환합니다.
    func requestCancelMembership(email: String) -> AnyPublisher<CancelMembershipResponseModel, AccountError>
}
