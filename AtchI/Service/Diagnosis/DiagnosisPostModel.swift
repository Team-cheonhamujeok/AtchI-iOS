//
//  DiagnosisModel.swift
//  AtchI
//
//  Created by 강민규 on 2023/05/01.
//

import Foundation

struct DiagnosisPostModel: Codable {
    let mid: Int
    let answerlist: [Int]
    let date: String
}

struct DiagnosisGetModel: Codable {
    let did: Int
    let mid: Int
    let result: Int
    let date: String
    let answerlist: [Int]
}
