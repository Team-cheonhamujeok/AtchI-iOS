//
//  HKProviderError.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/05/01.
//

import Foundation

/// HKProvider가 throw하는 에러 종류입니다.
///
/// - Note: description을 통해 상세한 에러 설명을 확인할 수 있습니다.
enum HKProviderError: Error {
    /// Identifier 오류입니다.
    case identifierNotFound
    /// Healhkit Query 실패 오류입니다.
    case fetchSamplesFailed
    
    var description: String {
        switch self {
        case .identifierNotFound:
            return "identifier를 찾을 수 없습니다. 올바른 identifier를 입력했는지 확인해주세요."
        case .fetchSamplesFailed:
            return "Sample을 가져오는데 실패했습니다. 건강 데이터에 대한 접근 권한 및 디바이스 상태를 확인해주세요."
        }
    }
}
