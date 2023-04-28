//
//  ValidationService.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/04/27.
//

import Foundation

/// 회원가입에 필요한 검증 로직 Service입니다.
class ValidationService {
    
    /// 이름 형식이 맞는지 검증합니다.
    ///
    /// 이름은 영문과 한글을 혼용해서 사용할 수 없습니다.
    ///
    /// - Parameters:
    ///    - password: String타입의 이메일을 전달합니다.
    /// - Returns: 형식이 올바르면 true, 올바르지 않으면 false를 리턴합니다.
    func isValidNameFormat(_ name: String) -> Bool {
        let nameRegex = "^[가-힣a-zA-Z]{1,}"
        let nameTest = NSPredicate(format: "SELF MATCHES %@", nameRegex)
        return nameTest.evaluate(with: name)
    }
    
    /// 이메일 형식이 맞는지 검증합니다.
    ///
    /// - Parameters:
    ///    - email: String타입의 이메일을 전달합니다.
    /// - Returns: 형식이 올바르면 true, 올바르지 않으면 false를 리턴합니다.
    func isValidEmailFormat(_ email: String) -> Bool {
        let emailPattern = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailPattern)
        return emailPredicate.evaluate(with: email)
    }
    
    /// 비밀번호 형식이 맞는지 검증합니다.
    ///
    /// 비밀번호는 8자리 이상 숫자, 영문/숫자/특수 문자로 구성되며 영문/숫자/특수문자를 각 1개 이상씩 포함하여야합니다.
    ///
    /// - Parameters:
    ///    - password: String타입의 이메일을 전달합니다.
    /// - Returns: 형식이 올바르면 true, 올바르지 않으면 false를 리턴합니다.
    func isValidPasswordFormat(_ password: String) -> Bool {
        let passwordRegex = "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[@$!%*?&])[A-Za-z\\d@$!%*?&]{8,}$"
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        return passwordTest.evaluate(with: password)
    }
    
    /// 생년월일 형식이 맞는지 검증합니다.
    ///
    /// 생년월일은 6자리 숫자 형태입니다. 예를 들어 1999년 1월 1일생이면 990101로 표기합니다.
    ///
    /// - Parameters:
    ///    - password: String타입의 이메일을 전달합니다.
    /// - Returns: 형식이 올바르면 true, 올바르지 않으면 false를 리턴합니다.
    func isValidBirthFormat(_ birthday: String) -> Bool {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyMMdd"
        if let date = dateFormatter.date(from: birthday) {
            let calendar = Calendar.current
            let components = calendar.dateComponents([.year, .month, .day], from: date)
            return components.year != nil && components.month != nil && components.day != nil
        }
        return false
    }
}
