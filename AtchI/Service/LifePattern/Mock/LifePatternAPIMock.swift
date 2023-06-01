//
//  LifePatternAPIMock.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/06/01.
//

import Foundation

enum LifePatternAPIMock {
    
    case lastDate(_ lastDateResponse: LastDateResponseType)
    
    var request: Int {
        switch self {
        case .lastDate(let type):
            switch type {
            case .exists: return 2
            case .doesNotExist: return 3
            }
        }
    }
    
    var response: String {
        switch self {
        case .lastDate(let type):
            switch type {
            case .exists: return """
                                {
                                    "success": true,
                                    "response": {
                                        "mid": 1,
                                        "lastDate": "2024-05-26T15:00:00.000+00:00"
                                    },
                                    "error": ""
                                }
                                """
            case .doesNotExist: return """
                                        {
                                            "success": true,
                                            "response": {},
                                            "error": ""
                                        }
                                        """
            }
        }
    }
    
    enum LastDateResponseType {
        case exists
        case doesNotExist
    }
}

extension LifePatternAPI {
    func getLastDateMockResponse(mid: Int) -> String {
        switch mid {
        case LifePatternAPIMock.lastDate(.exists).request:
            return LifePatternAPIMock.lastDate(.exists).response
        case LifePatternAPIMock.lastDate(.doesNotExist).request:
            return LifePatternAPIMock.lastDate(.doesNotExist).response
        default:
            return ""
        }
    }
}
