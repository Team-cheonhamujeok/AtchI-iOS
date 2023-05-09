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
                do {
                    return try response.map(EmailVerificationResponseModel.self)
                } catch {
                    fatalError("Failed to parse JSON")
                }
            }
            .mapError { error in
                // 내부 Publisher에서 발생한 에러를 다른 에러 타입으로 변환
                return AccountError.emailVerification(.sendEmailConfirmFailed)
            }
            .eraseToAnyPublisher()
    }
    
    func requestSignup(signupModel: SignupReqeustModel) -> AnyPublisher<Void, AccountError> {
        return provider.requestPublisher(.signup(signupModel))
            .tryMap { response in
                return
            }
            .mapError { error in
                // 내부 Publisher에서 발생한 에러를 다른 에러 타입으로 변환
                return AccountError.signup(.signupFailed)
            }
            .eraseToAnyPublisher()
    }
    
    func requestLogin(loginModel: LoginRequestModel) -> AnyPublisher<Void, AccountError> {
        return provider.requestPublisher(.login(loginModel))
            .tryMap { response in
                let decodedData = try response.map(LoginResponseModel.self)
                if decodedData.mid == 0 {
                    throw AccountError.login(.wrongPassword)
                } else if decodedData.mid == -2 {
                    throw AccountError.login(.userNotFound)
                }
                return
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
