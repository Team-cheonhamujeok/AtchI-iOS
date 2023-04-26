//
//  ValidationErrorMessage.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/04/27.
//

import Foundation

enum ValidationErrorMessage {
    case invalidName
    case invalidEmail
    case invalidBirth
    case invalidPassword
    case invalidPasswordAgain
    
    var description: String {
        switch self {
        case .invalidName:
            return "이름 형식이 올바르지 않습니다"
        case .invalidEmail:
            return "이메일 형식이 올바르지 않습니다"
        case .invalidBirth:
            return "6자리 숫자 형식으로 입력해주세요"
        case .invalidPassword:
            return "영문자, 숫자, 특수문자를 포함한 8자리 이상 비밀번호를 입력해주세요"
        case .invalidPasswordAgain:
            return "비밀번호가 일치하지 않습니다"
        }
    }
}
