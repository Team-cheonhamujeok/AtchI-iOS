//
//  LifePatternAPIMock.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/06/01.
//

import Foundation

enum LifePatternAPIMock {
    
    enum SaveLifePatternMock {
        case lastDateIsToday
        
        var response: String {
            switch self {
            case .lastDateIsToday:
                return """
                    {
                        "mid": 1,
                        "lastDate": "2024-05-26T15:00:00.000+00:00",
                        "lpCount": 338,
                        "predictStart": true,
                        "result": "치매 전조증상",
                        "resultProba": 0.851975347578765
                    }
                    """
            }
        }
    }
    
    enum LastDateMock {
        case exists
        case doesNotExist
        
        var request: Int {
            switch self {
            case .exists: return 2
            case .doesNotExist: return 3
            }
        }
        
        var response: String {
            switch self {
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
}
    
    // MARK: Mapping
    extension LifePatternAPI {
        
        func getLastDateMockResponse(mid: Int) -> String {
            switch mid {
            case LifePatternAPIMock.LastDateMock.exists.request:
                return LifePatternAPIMock.LastDateMock.exists.response
            case LifePatternAPIMock.LastDateMock.doesNotExist.request:
                return LifePatternAPIMock.LastDateMock.doesNotExist.response
            default:
                return ""
            }
        }
        
        func getSaveLifePatternResponse(lastDate: String) -> String {
            return LifePatternAPIMock.SaveLifePatternMock.lastDateIsToday.response
        }
    }
