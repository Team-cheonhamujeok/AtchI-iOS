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
    case signup(_ signupModel: SignupModel)
    case login
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
        case .login:
            return .requestPlain // DTO 만들고 수정 예정
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
    
    var cancellables = Set<AnyCancellable>()
    
    func requestEmailConfirm(email: String) -> AnyPublisher<EmailVerificationModel, AccountError> {
        return provider.requestPublisher(.emailConfirm(email))
            .tryMap { response -> EmailVerificationModel in
                do {
                    let decodedData = try response.map(EmailVerificationModel.self)
                    return decodedData
                } catch {
                    throw AccountError.common(.jsonSerializationFailed)
                }
            }
            .mapError { error in
                // 내부 Publisher에서 발생한 에러를 다른 에러 타입으로 변환
                return AccountError.sendEmailConfirmFailed
            }
            .eraseToAnyPublisher()
    }
    
    func requestSignup(signupModel: SignupModel) -> AnyPublisher<Response, AccountError> {
        return provider.requestPublisher(.signup(signupModel))
            .tryMap { response -> Response in
                return response
            }
            .mapError { error in
                // 내부 Publisher에서 발생한 에러를 다른 에러 타입으로 변환
                return AccountError.signupFailed
            }
            .eraseToAnyPublisher()
    }
}
