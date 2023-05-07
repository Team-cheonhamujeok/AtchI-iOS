//
//  EmailVerificationModel.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/04/29.
//

import Foundation

/// 이메일 인증 응답 형식입니다.
struct EmailVerificationResponseModel: Codable {
    let message: String
    let verificationCode: String
    
    enum CodingKeys: String, CodingKey {
        case message = "message"
        case verificationCode = "certificationNumber"
    }
}
