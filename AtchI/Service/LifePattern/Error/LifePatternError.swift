//
//  LifePatternError.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/05/25.
//

import Foundation

enum LifePatternError: Error, Equatable {
    case saveLifePattern(_ : SaveLifePatternError)
    /// 기타 에러입니다.
    case lastDate(_ : LastDateError)
    /// 그 외 실패입니다.
    case requestFailed(_ : Error)

    /// Life Pattern 저장 요청에 관련된 에러입니다.
    enum SaveLifePatternError: Error, Equatable {
        // 마지막 업데이트가 오늘입니다.
        case lastDateIsToday
    }
    
    /// Life Pattern 마지막 업데이트 날짜 요청에 대한 에러입니다.
    enum LastDateError: Error, Equatable {
    }
    
    static func == (lhs: LifePatternError, rhs: LifePatternError) -> Bool {
        switch (lhs, rhs) {
        case let (.saveLifePattern(error1), .saveLifePattern(error2)):
            return error1 == error2
        case (.lastDate, .lastDate):
            return true
        case (.requestFailed, .requestFailed):
            return true
        default:
            return false
        }
    }
}

//extension LifePatternError: Error {
//  public var description: String? {
//    switch self {
//    case .emptyRecord:
//      return "받아오는 데이터가 없습니다 (?)"
//    case .sendFailed:
//      return "알 수 없는 오류로 실패했습니다."
//    }
//  }
//}
