//
//  LifePatternAPI.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/05/13.
//

import Foundation

import Moya

enum LifePatternAPI{
    case sendLifePattern(_ lifePatternModel: LifePatternModel)
}

extension LifePatternAPI: TargetType {
    var baseURL: URL {
        if let url = URL(string: Bundle.main.infoDictionary?["BACKEND_ENDPOINT"] as! String){
            return url
        } else {
            fatalError("The BACKEND_ENDPOINT environment variable was not found.")
        }
    }
    
    var path: String {
        switch self {
        case .sendLifePattern:
            return "/lifePattern" // FIXME: 임시
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .sendLifePattern:
            return .post
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .sendLifePattern(let model):
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
    
    // MARK: - For test
//    var sampleData: Data {
//        switch self {
//        case .login(let loginModel):
//            let response = getLoginMockResponse(loginModel: loginModel)
//            return try! JSONSerialization.data(withJSONObject: response, options: [])
//        default:
//            let response: [String: Any] = ["": ""]
//            return try! JSONSerialization.data(withJSONObject: response, options: [])
//        }
//    }
}
