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
enum HKError: Error {
    /// Healhkit query 실패 오류입니다.
    case providerFetchSamplesFailed(error: Error)
    /// Healhkit query 결과가 비어있습니다.
    case providerDataNotFound
    /// 애플워치 데이터가 없습니다.
    case watchDataNotFound
    
    var description: String {
        switch self {
        case .providerFetchSamplesFailed:
            return "(provider) Sample을 가져오는데 실패했습니다. 건강 데이터에 대한 접근 권한 및 디바이스 상태를 확인해주세요."
        case .providerDataNotFound:
            return "(provider) query는 성공했으나, 값이 비어있습니다."
        case .watchDataNotFound:
            return "애플워치 데이터가 없습니다"
        }
    }
}
