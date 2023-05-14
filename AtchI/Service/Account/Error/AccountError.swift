//
//  AccountError.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/04/15.
//

import Foundation

// 이건 나중에 Service로 빼기
enum CommonError: Error {
    case networkError(String)
    
    // 각 케이스를 문자열로 반환
    var description: String {
        switch self {
        case .networkError(let message):
            return "네트워크 에러가 발생했습니다. 네트워크 상태를 확인해주세요."
        }
    }
}

/// Account API Error
enum AccountError: Error {
    
    /// Common Error
    case common(_ : CommonError)
    /// Account API Signup Error
    case signup(_ :SignupError)
    /// Account API Email Verification Error
    case emailVerification(_ :EmailVerificationError)
    /// Account API Login Error
    case login(_ : LoginError)
    
    var description: String {
        switch self {
        case .common(let error):
            return error.description
        case .signup(let error):
            return error.description
        case .emailVerification(let error):
            return error.description
        case .login(let error):
            return error.description
        }
    }
}

extension AccountError {
    
    enum SignupError: Error {
        case signupFailed
        case emailDuplicated
        
        // 각 케이스를 문자열로 반환
        var description: String {
            switch self {
            case .signupFailed:
                return "예상치 못한 원인으로 회원가입에 실패하였습니다."
            case .emailDuplicated:
                return "중복된 이메일입니다."
            }
        }
    }
    
    enum EmailVerificationError: Error {
        case sendEmailConfirmFailed
        
        var description: String {
            switch self {
            case .sendEmailConfirmFailed:
                return "인증 이메일 전송에 실패했습니다. 다시 시도해주세요."
            }
        }
    }
    
    enum LoginError: Error {
        case wrongPassword
        case userNotFound
        case loginFailed
        
        var description: String {
            switch self {
            case .wrongPassword:
                return "비밀번호가 올바르지 않습니다."
            case .userNotFound:
                return "존재하지 않는 회원입니다."
            case .loginFailed:
                return "예상치 못한 원인으로 회원가입에 실패하였습니다."
            }
        }
    }
}

extension AccountError: Equatable {
    static func == (lhs: AccountError, rhs: AccountError) -> Bool {
        switch (lhs, rhs) {
        case (.common(let lhsError), .common(let rhsError)):
            return lhsError.localizedDescription == rhsError.localizedDescription
        case (.signup(let lhsError), .signup(let rhsError)):
            return lhsError.localizedDescription == rhsError.localizedDescription
        case (.emailVerification(let lhsError), .emailVerification(let rhsError)):
            return lhsError.localizedDescription == rhsError.localizedDescription
        case (.login(let lhsError), .login(let rhsError)):
            return lhsError.localizedDescription == rhsError.localizedDescription
        default:
            return false
        }
    }
}

