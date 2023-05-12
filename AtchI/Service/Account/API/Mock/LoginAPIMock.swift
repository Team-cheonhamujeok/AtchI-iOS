//
//  LoginAPIMock.swift
//  AtchIServiceTests
//
//  Created by DOYEON LEE on 2023/05/07.
//

import Foundation

/// 로그인 API(Service) 테스트를 위한 provider Mock 데이터입니다.
///
/// request와 매치되는 response에 쉽게 접근하기 위해 구성하였습니다.
enum LoginAPIMock {
    case success
    case wrongPassword
    case userNotFound
    case loginFaild
    
    var request: LoginRequestModel {
        switch self {
        case .success:
            return LoginRequestModel(id: "test@gmail.com", pw: "testtest123!")
        case .wrongPassword:
            return LoginRequestModel(id: "test@gmail.com", pw: "testtest123")
        case .userNotFound:
            return LoginRequestModel(id: "tes@gmail.com", pw: "testtest123!")
        case .loginFaild:
            return LoginRequestModel(id: "error", pw: "error")
        }
    }
    
    var response: [String: Any] {
        switch self {
        case .success:
            return ["message": "login succeed", "mid": 3]
        case .wrongPassword:
            return ["message": "wrong password", "mid": 0]
        case .userNotFound:
            return ["message": "No user exists", "mid": -2]
        case .loginFaild:
            return [:]
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
