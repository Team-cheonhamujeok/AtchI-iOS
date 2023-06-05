//
//  DiagnosisService.swift
//  AtchI
//
//  Created by 강민규 on 2023/05/01.
//

import Foundation
import Moya
import CombineMoya
import Combine

// MARK: - Mock Service 객체 만들기 위해 정의
protocol DiagnosisServiceType {
    func postDiagnosis(postDTO: DiagnosisPostModel) -> AnyPublisher<Response, DiagnosisError>
    func getDiagnosisList(mid: Int) -> AnyPublisher<Moya.Response, DiagnosisError>
}

// MARK: - DiagnosisAPI
enum DiagnosisAPI {
    case postList(postDTO: DiagnosisPostModel)
    case getList(mid: Int)
}

// MARK: - Moya TargetType 채택한 Enum
extension DiagnosisAPI: TargetType {
    var baseURL: URL {
        if let url = URL(string: Bundle.main.infoDictionary?["BACKEND_ENDPOINT"] as! String){
            return url
        } else {
            fatalError("The BACKEND_ENDPOINT environment variable was not found.")
        }
    }
    
    var path: String {
        switch self {
        case .postList:
            return "/addDiagnosis"
        case .getList:
            return "/getDiagnosisList"
        }
    }
        
    var method: Moya.Method {
        switch self {
        case .postList:
            return .post
        case .getList:
            return .get
        }
    }
        
    var task: Moya.Task {
        switch self {
        case .postList(let postDTO):
            return .requestJSONEncodable(postDTO)
        case .getList(let mid):
            return .requestParameters(parameters: ["mId": mid], encoding: URLEncoding.queryString)
        }
    }
        
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
}
    
// MARK: - Service Part
class DiagnosisService: DiagnosisServiceType {
    
    let provider: MoyaProvider<DiagnosisAPI>
    init(provider: MoyaProvider<DiagnosisAPI>) {
        self.provider = provider
    }
    
    var cancellables = Set<AnyCancellable>()
    
    func postDiagnosis(postDTO: DiagnosisPostModel) -> AnyPublisher<Moya.Response, DiagnosisError> {
        return provider.requestPublisher(.postList(postDTO: postDTO))
            .tryMap { response -> Response in
                return response
            }
            .mapError { error in
                // 내부 Publisher에서 발생한 에러를 다른 에러 타입으로 변환
                return DiagnosisError.postFail
            }
            .eraseToAnyPublisher()
    }
    
    func getDiagnosisList(mid: Int) -> AnyPublisher<Moya.Response, DiagnosisError> {
        return provider.requestPublisher(.getList(mid: mid))
            .tryMap { response -> Response in
                return response
            }
            .mapError { error in
                return DiagnosisError.getFail
            }
            .eraseToAnyPublisher()
    }
}

