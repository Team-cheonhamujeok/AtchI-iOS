//
//  AccountAPI.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/05/07.
//

import Foundation
import Moya

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
            return .requestJSONEncodable(loginModel)
        case .emailConfirm(let email):
            return .requestParameters(parameters: ["email" : email],
                                      encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
    
    // MARK: - For test
    var sampleData: Data {
        switch self {
        case .login(let loginModel):
            let response = getLoginMockResponse(loginModel: loginModel)
            return try! JSONSerialization.data(withJSONObject: response, options: [])
        default:
            let response: [String: Any] = ["": ""]
            return try! JSONSerialization.data(withJSONObject: response, options: [])
        }
    }
}

extension AccountAPI {
    func getLoginMockResponse(loginModel: LoginRequestModel) -> [String: Any] {
        switch loginModel {
        case LoginAPIMock.success.request:
            return LoginAPIMock.success.response
        case LoginAPIMock.wrongPassword.request:
            return LoginAPIMock.wrongPassword.response
        case LoginAPIMock.userNotFound.request:
            return LoginAPIMock.userNotFound.response
        case LoginAPIMock.loginFaild.request:
            return LoginAPIMock.loginFaild.response
        default:
            return [:]
        }
    }
}
