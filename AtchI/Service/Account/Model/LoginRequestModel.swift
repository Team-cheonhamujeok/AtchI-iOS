//
//  LoginModel.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/05/05.
//

import Foundation

/// 회원가입 요청  body입니다.
struct LoginRequestModel: Encodable, Equatable {
    let id: String
    let pw: String
}

extension LoginRequestModel {
    

}
