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
    

    case jsonSerializationFailed // json 파싱 에러 
}
