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

// Mock Service 객체 만들기 위해 정의
protocol DiagnosisServiceType {
    func postDiagnosis(diagnosisPostModel: DiagnosisPostModel) -> AnyPublisher<Response, DiagnosisError>
    func getDiagnosisList(diagnosisGetModel: DiagnosisGetModel) -> AnyPublisher<Moya.Response, DiagnosisError>
}

enum DiagnosisAPI {
    case postList(listDTO: DiagnosisPostModel)
    case getList(listDTO: DiagnosisGetModel)
}

extension DiagnosisAPI: TargetType {
    var baseURL: URL {
        URL(string: "http://203.255.3.48:1224")!
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
        case .postList(let diagnosisPostModel):
            return .requestJSONEncodable(diagnosisPostModel)
        case .getList(let diagnosisGetModel):
            return .requestJSONEncodable(diagnosisGetModel)
        }
    }
        
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
}
    
class DiagnosisService: DiagnosisServiceType {
    let provider = MoyaProvider<DiagnosisAPI>()
    
    var cancellables = Set<AnyCancellable>()
    
    func postDiagnosis(diagnosisPostModel: DiagnosisPostModel) -> AnyPublisher<Moya.Response, DiagnosisError> {
        return provider.requestPublisher(.postList(listDTO: diagnosisPostModel))
            .tryMap { response -> Response in
                return response
            }
            .mapError { error in
                // 내부 Publisher에서 발생한 에러를 다른 에러 타입으로 변환
                return DiagnosisError.postFail
            }
            .eraseToAnyPublisher()
    }
    
    func getDiagnosisList(diagnosisGetModel: DiagnosisGetModel) -> AnyPublisher<Moya.Response, DiagnosisError> {
        return provider.requestPublisher(.getList(listDTO: diagnosisGetModel))
            .tryMap { response -> Response in
                return response
            }
            .mapError { error in
                
                return DiagnosisError.getFail
            }
            .eraseToAnyPublisher()
    }
}

