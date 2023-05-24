//
//  GetQuizResponseModel.swift
//  AtchI
//
//  Created by 이봄이 on 2023/05/23.
//

import Foundation

struct GetQuizResponseModel: Codable {
    let message: String
    let tqid: Int
    let quiz1: String
    let quiz1Id: Int
    let quiz1Check: Bool
    let quiz2: String
    let quiz2Id: Int
    let quiz2Check: Bool
    let quiz3: String
    let quiz3Id: Int
    let quiz3Check: Bool
    let solve: Bool
    let quizdate: Date
}
