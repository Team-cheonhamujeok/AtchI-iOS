//
//  EmailVerificationState.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/04/29.
//

import Foundation

/**  이메일 인증 기능에 필요한 ViewModel 데이터입니다.
 
 ```
 struct EmailVerificationState {
     /// 인증 요청 가능 여부입니다. 이메일 형식 검증에 통과했을 시 true가 됩니다.
     var sendEnable: Bool = false
     /// 인증 요청 상태입니다. 첫번째 인증 메일 전송시 ture가 됩니다.
     var sended: Bool = false
     /// 인증 번호 확인 가능 여부입니다. 인증번호 형식과 맞을 시 ture가 됩니다.
     var checkEnable: Bool = false
     /// 인증 성공 여부입니다.
     var sucess: Bool = false
     /// 인증 실패 원인에 대한 메세지입니다.
     var failMessage: String = ""
 }
 ```
 */
struct EmailVerificationState {
    /// 인증 요청 가능 여부입니다. 이메일 형식 검증에 통과했을 시 true가 됩니다.
    var sendEnable: Bool = false
    /// 인증 요청 상태입니다. 첫번째 인증 메일 전송시 ture가 됩니다.
    var sended: Bool = false
    /// 인증 번호 확인 가능 여부입니다. 인증번호 형식과 맞을 시 ture가 됩니다.
    var checkEnable: Bool = false
    /// 인증 성공 여부입니다.
    var sucess: Bool = false
    /// 인증 실패 원인에 대한 메세지입니다.
    var failMessage: String = ""
}
