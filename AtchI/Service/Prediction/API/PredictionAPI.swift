//
//  PredictionAPI.swift
//  AtchI
//
//  Created by 강민규 on 2023/06/05.
//

import Foundation

import Moya

enum PredictionAPI {
    case getPredictList(mid: Int)
}

extension PredictionAPI: TargetType {
    var baseURL: URL {
        if let url = URL(string: Bundle.main.infoDictionary?["BACKEND_ENDPOINT"] as! String){
            return url
        } else {
            fatalError("The BACKEND_ENDPOINT environment variable was not found.")
        }
    }
    
    var path: String {
        switch self {
        case .getPredictList:
            return "/predictionModel"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getPredictList:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .getPredictList(let mid):
            return .requestParameters(parameters: ["mid": mid], encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
}
