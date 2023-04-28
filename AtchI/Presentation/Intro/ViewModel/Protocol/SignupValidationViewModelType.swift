//
//  SignupValidationViewModelType.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/04/29.
//

import Foundation

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
    /// 생년월일 형식에 대한 에러 메세지입니다.
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
