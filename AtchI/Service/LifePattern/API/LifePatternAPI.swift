//
//  LifePatternAPI.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/05/13.
//

import Foundation

import Moya

enum LifePatternAPI{
    case sendLifePattern(_ lifePatternModel: [LifePatternModel])
    case lastDate(_ mid: Int)
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
            return "/lifePattern"
        case .lastDate:
            return "/lifePattern/lastDate"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .sendLifePattern:
            return .post
        case .lastDate:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .sendLifePattern(let model):
            return .requestJSONEncodable(model)
        case .lastDate(let mid):
            return .requestParameters(parameters: ["mid" : mid],
                                      encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
    
    // MARK: - For test
    var sampleData: Data {
        var response: String = ""
        
        switch self {
        case .lastDate(let mid):
            response = getLastDateMockResponse(mid: mid)
            break
        case .sendLifePattern(_):
            response = getSaveLifePatternResponse(lastDate: "")
            break
        default:
            response = ""
            break
        }
        
        let jsonData = response.data(using: .utf8) ?? Data()
        return jsonData
    }
}

