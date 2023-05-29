//
//  LifePatternError.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/05/25.
//

import Foundation

enum LifePatternError {
    /// 받아오는 데이터가 없습니다. (<<정확히 모르겠음)
    case emptyRecord
    /// 500에러입니다.
    case sendFailed
}

extension LifePatternError: Error {
  public var description: String? {
    switch self {
    case .emptyRecord:
      return "받아오는 데이터가 없습니다 (?)"
    case .sendFailed:
      return "알 수 없는 오류로 실패했습니다."
    }
  }
}
