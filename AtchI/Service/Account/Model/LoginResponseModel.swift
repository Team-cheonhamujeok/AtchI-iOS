//
//  LoginResponseModel.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/05/05.
//

import Foundation

/// 로그인 응답 형식입니다.
struct LoginResponseModel: Codable, Equatable {
    let message: String
    let mid: Int
}
