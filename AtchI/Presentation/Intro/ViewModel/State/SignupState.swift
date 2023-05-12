//
//  SignupState.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/04/29.
//

import Foundation

/**  이메일 인증 기능에 필요한 ViewModel 데이터입니다.
 
 ```
 struct SignupState {
     /// 회원가입이 가능한 상태인지 나타냅니다. 입력값이 모두 형식 검사를 통과했을때 true가 됩니다.
     var signupEnable: Bool = false
     /// 회원가입 실패 원인에 대한 메세지입니다.
     var failMessage: String = ""
 }
 ```
 */
struct SignupState {
    /// 회원가입 버튼의 상태를 나타냅니다.
    var signupButtonState: ButtonState = .disabled
    /// 회원가입 실패 원인에 대한 메세지입니다.
    var failMessage: String = ""
}
