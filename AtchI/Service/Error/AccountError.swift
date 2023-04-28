//
//  AccountError.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/04/15.
//

import Foundation

enum CommonError: Error {
    case jsonSerializationFailed
    
    // 각 케이스를 문자열로 반환
    var description: String {
        switch self {
        case .jsonSerializationFailed:
            return "예상치 못한 원인으로 회원가입에 실패하였습니다"
        }
    }
}


enum AccountError: Error {
    
    // Signup
    case signupFailed
    case networkError(String)
    case emailDuplicated
    
    // EmailConfirm
    case sendEmailConfirmFailed
    
    // EmailConfirm
    case common(_ commonError: CommonError) // json 파싱 에러
    
    // 각 케이스를 문자열로 반환
    var description: String {
        switch self {
        case .signupFailed:
            return "예상치 못한 원인으로 회원가입에 실패하였습니다"
        case .networkError(let message):
            return "네트워크 에러가 발생했습니다: \(message)"
        case .emailDuplicated:
            return "중복된 이메일입니다"
        case .sendEmailConfirmFailed:
            return "인증 이메일 전송에 실패했습니다. 다시 시도해주세요."
        case .common(let err):
            return err.description
        }
    }
    
}
