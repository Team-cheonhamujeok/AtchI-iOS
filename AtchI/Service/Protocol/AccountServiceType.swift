//
//  AccountServiceType.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/04/15.
//

import Foundation
import Combine
import Moya

// Mock Service 객체 만들기 위해 정의
protocol AccountServiceType {
    func requestSignup(signupModel: SignupModel) -> AnyPublisher<Response, AccountError> 
}
