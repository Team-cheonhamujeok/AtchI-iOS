//
//  QuizAPI.swift
//  AtchI
//
//  Created by 이봄이 on 2023/05/21.
//

import Foundation
import Moya

enum QuizAPI {
    case getQuiz(_ mid: Int)
    case checkQuiz(_ quizCheckModel: QuizCheckRequestModel)
    case getWeekQuiz(_ mid: Int)
}

extension QuizAPI: TargetType {
    var baseURL: URL {
        if let url = URL(string: Bundle.main.infoDictionary?["BACKEND_ENDPOINT"] as! String){
            return url
        } else {
            fatalError("The BACKEND_ENDPOINT environment variable was not found.")
        }
    }
    
    var path: String {
        switch self {
        case .getQuiz:
            return "/newTodayQuiz"
        case .checkQuiz:
            return "/checkQuiz"
        case .getWeekQuiz(_):
            return "/newWeek"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getQuiz, .getWeekQuiz:
            return .get
        case .checkQuiz:
            return .post
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .getQuiz(let mid):
            return .requestParameters(parameters: ["mid" : mid],
                                      encoding: URLEncoding.queryString)
        case .checkQuiz(let quizCheckModel):
            return .requestJSONEncodable(quizCheckModel)
        case .getWeekQuiz(let mid):
            return .requestParameters(parameters: ["mid" : mid],
                                      encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
}
