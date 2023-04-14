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
    case signup(signupDTO: SignupDTO)
    case login
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
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .signup, .login:
            return .post
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .signup(let signupDTO):
            return .requestJSONEncodable(signupDTO)
        case .login:
            return .requestPlain // DTO 만들고 수정 예정
        }
    }
    
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
}


class AccountService {
    let provider = MoyaProvider<AccountAPI>()
    
    var cancellables = Set<AnyCancellable>()
    
    func reqSignup(signupDTO: SignupDTO) -> AnyPublisher<Response, MoyaError> {
        return provider.requestPublisher(.signup(signupDTO: signupDTO))
    }
}


enum AccountError: Error {
    case signupFailed
    case networkError(String)
    // 필요에 따라 추가적인 에러 케이스를 정의할 수 있음
}





