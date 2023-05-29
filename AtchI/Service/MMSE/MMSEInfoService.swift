//
//  MMSEInfoService.swift
//  AtchI
//
//  Created by 강민규 on 2023/05/29.
//

import Foundation
import Moya
import CombineMoya
import Combine

// MARK: - MMSEInfoServiceAPI
enum MMSEInfoAPI {
    case getList(mid: Int)
}

// MARK: - Moya TargetType 채택한 Enum
extension MMSEInfoAPI: TargetType {
    var baseURL: URL {
        URL(string: "http://203.255.3.48:1224")!
    }

    var path: String {
        switch self {
        case .getList:
            return "/MMSE/getAllMMSE"
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
        case .getList(let mid):
            return .requestParameters(parameters: ["mid": mid], encoding: URLEncoding.queryString)
        }
    }
        
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
}
    
// MARK: - Service Part
class MMSEInfoService {
    
    let provider: MoyaProvider<MMSEInfoAPI>
    init(provider: MoyaProvider<MMSEInfoAPI>) {
        self.provider = provider
    }
    
    var cancellables = Set<AnyCancellable>()
    
    func getMMSEResults(mid: Int) -> AnyPublisher<Moya.Response, MMSEInfoError> {
        return provider.requestPublisher(.getList(mid: mid))
            .tryMap { response -> Response in
                return response
            }
            .mapError { error in
                return MMSEInfoError.getFail
            }
            .eraseToAnyPublisher()
    }
}

