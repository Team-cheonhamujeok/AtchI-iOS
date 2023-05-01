//
//  MockValidationServcie.swift
//  AtchIViewModelTests
//
//  Created by DOYEON LEE on 2023/04/30.
//

@testable import AtchI
import Foundation

enum MockValidation {
    case name
    case email
    case password
    case birth
    
    var valid: String {
        switch self {
        case .name:
            return "전종설"
        case .email:
            return "jonsul@naver.com"
        case .password:
            return "wjswhdtjf123!"
        case .birth:
            return "010101"
        }
    }
}

class MockValidationServcie: ValidationServiceType {
    func isValidNameFormat(_ name: String) -> Bool {
        return name == MockValidation.name.valid
    }
    
    func isValidEmailFormat(_ email: String) -> Bool {
        return email == MockValidation.email.valid
    }
    
    func isValidPasswordFormat(_ password: String) -> Bool {
        return password == MockValidation.password.valid
    }
    
    func isValidBirthFormat(_ birthday: String) -> Bool {
        return birthday == MockValidation.birth.valid
    }
}
