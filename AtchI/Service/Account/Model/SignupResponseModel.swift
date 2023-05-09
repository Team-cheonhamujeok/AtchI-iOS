//
//  SignupResponseModel.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/05/09.
//

import Foundation

/// 회원가입 응답 형식입니다.
struct SignupResponseModel: Codable, Equatable {
    let message: String
    let mid: Int
}
