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

enum AccountAPI{
    case signup(_ signupModel: SignupReqeustModel)
    case login(_ loginModel: LoginRequestModel)
    case emailConfirm(_ email: String)
}

extension AccountAPI: TargetType {
    var baseURL: URL {
        URL(string: "http://203.255.3.48:1224")!
    }
    
    var path: String {
        switch self {
        case .signup:
            return "/signup"
        case .login:
            return "/login"
        case .emailConfirm:
            return "/mailConfirm"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .emailConfirm:
            return .get
        case .signup, .login:
            return .post
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .signup(let signupModel):
            return .requestJSONEncodable(signupModel)
        case .login(let loginModel):
            return .requestJSONEncodable(loginModel) // DTO 만들고 수정 예정
        case .emailConfirm(let email):
            return .requestParameters(parameters: ["email" : email],
                                      encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
}


class AccountService: AccountServiceType {
//    let provider = MoyaProvider<AccountAPI>(plugins: [NetworkLoggerPlugin()])
    let provider = MoyaProvider<AccountAPI>()
    let testing = MoyaProvider<AccountAPI)(StubBehavior)
    
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
                return AccountError.sendEmailConfirmFailed
            }
            .eraseToAnyPublisher()
    }
    
    func requestSignup(signupModel: SignupReqeustModel) -> AnyPublisher<Response, AccountError> {
        return provider.requestPublisher(.signup(signupModel))
            .tryMap { response -> Response in
                return response
            }
            .mapError { error in
                // 내부 Publisher에서 발생한 에러를 다른 에러 타입으로 변환
                return AccountError.singup(.signupFailed)
            }
            .eraseToAnyPublisher()
    }
    
    func requestLogin(loginModel: LoginRequestModel) -> AnyPublisher<LoginResponseModel, AccountError> {
        return provider.requestPublisher(.login(loginModel))
            .tryMap { response -> LoginResponseModel in
                do {
                    let decodedData = try response.map(LoginResponseModel.self)
                    if decodedData.mid == 0 {
                        throw AccountError.login(.wrongPassword)
                    } else if decodedData.mid == -2 {
                        throw AccountError.login(.userNotFound)
                    }
                    return try response.map(LoginResponseModel.self)
                } catch {
                    fatalError("Failed to parse JSON")
                }
                throw AccountError.login(.userNotFound)
            }
            .mapError { error in
                // 내부 Publisher에서 발생한 에러를 다른 에러 타입으로 변환
                return AccountError.login(.loginFaild)
            }
            .eraseToAnyPublisher()
    }
}
