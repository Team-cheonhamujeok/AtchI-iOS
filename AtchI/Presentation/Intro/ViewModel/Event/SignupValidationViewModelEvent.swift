//
//  SignupValidationViewModelEvent.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/04/29.
//

import Foundation

enum SignupValidationViewModelEvent {
    
    case emailValid(email: String)
    case emailInvalid
    case allInputValid
    case sendInfoForSignup(Info: InfoState)

}
