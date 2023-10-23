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
    
    
    init(provider: MoyaProvider<AccountAPI>,
         cancellables: Set<AnyCancellable> = Set<AnyCancellable>()) {
        self.provider = provider
        self.cancellables = cancellables
    }
    
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
                print("error: \(error)")
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
            .tryCatch { error in
                if (500..<599) ~= error.response?.statusCode ?? 0 {
                    return Just(())
                      .delay(for: 3, scheduler: DispatchQueue.global())
                      .flatMap { _ in
                          return self.provider.requestPublisher(.login(loginModel))
                      }
                      .retry(3)
                      .eraseToAnyPublisher()
                } else {
                    throw error
                }
            }
            .mapError { _ in
                return AccountError.login(.loginFailed)
            }
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
                return error as! AccountError
            }
            .eraseToAnyPublisher()
    }
    
    func requestCancelMembership(email: String) -> AnyPublisher<CancelMembershipResponseModel, AccountError> {
        return provider.requestPublisher(.cancelMembership(email))
            .tryMap { response -> CancelMembershipResponseModel in
                return try response.map(CancelMembershipResponseModel.self)
            }
            .mapError { error in
                // 내부 Publisher에서 발생한 에러를 다른 에러 타입으로 변환
                return AccountError.cancelMembership(.otherError)
            }
            .eraseToAnyPublisher()
    }
}
