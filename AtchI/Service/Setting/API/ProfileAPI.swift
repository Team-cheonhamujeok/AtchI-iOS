//
//  ProfileAPI.swift
//  AtchI
//
//  Created by 강민규 on 2023/07/28.
//

import Foundation
import Moya

// MARK: - MMSEInfoServiceAPI
enum ProfileAPI {
    case getList(email: String)
}

// MARK: - Moya TargetType 채택한 Enum
extension ProfileAPI: TargetType {
    var baseURL: URL {
        if let url = URL(string: Bundle.main.infoDictionary?["BACKEND_ENDPOINT"] as! String) {
            return url
        } else {
            fatalError("The BACKEND_ENDPOINT environment variable was not found.")
        }
    }
    
    var path: String {
        switch self {
        case .getList:
            return "/userInfo"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getList:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .getList(let email):
            return .requestParameters(parameters: ["email": email], encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
}

