//
//  MMSEResultType.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/05/30.
//

import Foundation

extension MMSEQuestionType {
    var resultType: MMSEResultType {
        switch self {
        case .reply(let replyType):
            switch replyType {
            case .year, .day, .week, .month: return .timePerception
            case .country, .city: return .spatialPerception
            case .airplane, .pencil, .tree: return .memoryEncodingRecall
            }
        case .arithmetic(_): return .attentionCalculation
        case .image(_): return .memoryEncodingRecall
        default: return .nothing
            
        }
    }
}


/// MMSE 검사 결과를 위한 문항 분류입니다.
enum MMSEResultType: CaseIterable {
    /// 시간 지남력
    case timePerception
    /// 공간 지남력
    case spatialPerception
    /// 주의 집중 및 계산
    case attentionCalculation
    /// 기억 등록 / 회상
    case memoryEncodingRecall
    /// 언어
    case language
    /// 그 외
    case nothing
    
    var description: String {
        switch self {
        case .timePerception: return "시간 지남력"
        case .spatialPerception: return "공간 지남력"
        case .attentionCalculation: return "주의 집중 및 계산"
        case .memoryEncodingRecall: return "기억 등록 / 기억 회상"
        case .language: return "언어"
        case .nothing: return ""
        }
    }
}


