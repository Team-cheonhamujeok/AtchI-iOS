//
//  AccountService.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/04/08.
//

import Foundation
import Moya
import CombineMoya
import Combine

class AccountService: AccountServiceType {
//    let provider = MoyaProvider<AccountAPI>(plugins: [NetworkLoggerPlugin()])
    let provider: MoyaProvider<AccountAPI>
    
    init(provider: MoyaProvider<AccountAPI>){
        self.provider = provider
    }
    
    var cancellables = Set<AnyCancellable>()
    
    func requestEmailConfirm(email: String) -> AnyPublisher<EmailVerificationResponseModel, AccountError> {
        return provider.requestPublisher(.emailConfirm(email))
            .tryMap { response -> EmailVerificationResponseModel in
                return try response.map(EmailVerificationResponseModel.self)
            }
            .mapError { error in
                // 내부 Publisher에서 발생한 에러를 다른 에러 타입으로 변환
                return AccountError.emailVerification(.sendEmailConfirmFailed)
            }
            .eraseToAnyPublisher()
    }
    
    func requestSignup(signupModel: SignupReqeustModel) -> AnyPublisher<SignupResponseModel, AccountError> {
        return provider.requestPublisher(.signup(signupModel))
            .tryMap { response in
                let decodedData = try response.map(SignupResponseModel.self)
                if decodedData.message == "There are duplicate users" {
                    throw AccountError.signup(.emailDuplicated)
                }
                return decodedData
            }
            .mapError { error in
                // 내부 Publisher에서 발생한 에러를 다른 에러 타입으로 변환
                if error is MoyaError {
                    return AccountError.signup(.signupFailed)
                } else {
                    return error as! AccountError
                }
            }
            .eraseToAnyPublisher()
    }
    
    func requestLogin(loginModel: LoginRequestModel) -> AnyPublisher<LoginResponseModel, AccountError> {
        return provider.requestPublisher(.login(loginModel))
            .tryMap { response in
                let decodedData = try response.map(LoginResponseModel.self)
                if decodedData.mid == 0 {
                    throw AccountError.login(.wrongPassword)
                } else if decodedData.mid == -2 {
                    throw AccountError.login(.userNotFound)
                }
                return decodedData
            }
            .mapError { error in
                if error is MoyaError {
                    return AccountError.login(.loginFaild)
                } else {
                    return error as! AccountError
                }
            }
            .eraseToAnyPublisher()
    }
}
