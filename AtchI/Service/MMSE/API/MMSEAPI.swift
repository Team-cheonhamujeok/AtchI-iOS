//
//  MMSEAPI.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/05/30.
//

import Foundation
import Moya

// MARK: - MMSEInfoServiceAPI
enum MMSEAPI {
    case getList(mid: Int)
    case saveMMES(model: MMSESaveRequestModel)
}

// MARK: - Moya TargetType 채택한 Enum
extension MMSEAPI: TargetType {
    var baseURL: URL {
        if let url = URL(string: Bundle.main.infoDictionary?["BACKEND_ENDPOINT"] as! String){
            return url
        } else {
            fatalError("The BACKEND_ENDPOINT environment variable was not found.")
        }
    }
    
    var path: String {
        switch self {
        case .getList:
            return "/MMSE/getAllMMSE"
        case .saveMMES(model: _):
            return "/MMSE"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getList:
            return .get
        case .saveMMES(model: _):
            return  .post
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .getList(let mid):
            return .requestParameters(parameters: ["mid": mid], encoding: URLEncoding.queryString)
        case .saveMMES(model: let model):
            return .requestJSONEncodable(model)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
}
