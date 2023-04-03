//
//  ViewErrorMessage.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/04/03.
//

import Foundation

enum ViewErrorMessage: Error {
    case invalidEmail
    
    var krDescription: String {
        switch self {
        case .invalidEmail:
            return "이메일형식에 맞게 입력해주세요"
        }
    }
}
