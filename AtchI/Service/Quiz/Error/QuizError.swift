//
//  QuizError.swift
//  AtchI
//
//  Created by 이봄이 on 2023/05/23.
//

import Foundation

enum QuizError: Error {
    
    case common(_ :CommonError)
    case getQuiz(_ :GetQuizError)
    case checkQuiz(_ :CheckQuizError)
    
    var description: String {
        switch self {
        case .common(let error):
            return error.description
        case .getQuiz(let error):
            return error.decription
        case .checkQuiz(let error):
            return error.description
        }
    }
}

extension QuizError {
    enum GetQuizError: Error {
        case noUser
        case saveFailed
        case duplicateUsers
        case fetchFailed
        
        var decription: String {
            switch self {
            case .noUser:
                return "유저를 찾을 수 없습니다."
            case .saveFailed:
                return "DB에 저장하지 못 했습니다."
            case .duplicateUsers:
                return "중복되는 유저가 있습니다."
            case .fetchFailed:
                return "퀴즈를 불러오지 못 했습니다."
            }
        }
    }
    
    enum CheckQuizError: Error {
        case noID
        case checkError
        
        var description: String {
            switch self {
            case .noID:
                return "해당되는 오늘의 퀴즈 ID가 없습니다."
            case .checkError:
                return "확인하는 중 알 수 없는 오류가 발생했습니다. 다시 시도해주세요."
            }
        }
    }
}
