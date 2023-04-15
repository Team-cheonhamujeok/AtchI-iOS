//
//  AccountError.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/04/15.
//

import Foundation

enum AccountError: Error {
    case signupFailed
    case networkError(String)
    // 필요에 따라 추가적인 에러 케이스를 정의할 수 있음
    
    case emailDuplicated
    

    case jsonSerializationFailed // json 파싱 에러
    
    // 각 케이스를 문자열로 반환하는 함수
    func krDescription() -> String {
        switch self {
        case .signupFailed:
            return "예상치 못한 원인으로 회원가입에 실패하였습니다"
        case .networkError(let message):
            return "네트워크 에러가 발생했습니다: \(message)"
        case .emailDuplicated:
            return "중복된 이메일입니다"
        case .jsonSerializationFailed:
            return "올바른 서버 응답이 아닙니다 -> 이건 보여지면 안됨"
        }
    }
    
}
