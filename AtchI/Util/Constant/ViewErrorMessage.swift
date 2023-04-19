//
//  ViewErrorMessage.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/04/03.
//

import Foundation

enum ViewErrorMessage: Error {
    case invalidEmail
    case invalidPassword
    
    var krDescription: String {
        switch self {
        case .invalidEmail:
            return "이메일형식에 맞게 입력해주세요"
        case .invalidPassword:
            return "영문자, 숫자, 특수문자를 포함한 8자리 이상 비밀번호를 입력해주세요"
        }
    }
}
