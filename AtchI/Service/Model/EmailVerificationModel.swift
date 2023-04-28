//
//  EmailVerificationModel.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/04/29.
//

import Foundation

struct EmailVerificationModel: Codable {
    let message: String
    let verificationCode: String
    
    enum CodingKeys: String, CodingKey {
        case message = "message"
        case verificationCode = "certificationNumber"
    }
}
