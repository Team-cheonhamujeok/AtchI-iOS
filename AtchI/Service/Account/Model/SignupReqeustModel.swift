//
//  SignupDTO.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/04/13.
//

import Foundation

/// 회원가입 요청  body입니다.
struct SignupReqeustModel: Encodable {
    let email: String
    let pw: String
    let birthday: String
    let gender: Bool
    let name: String
}
