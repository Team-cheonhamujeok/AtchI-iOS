//
//  QuizRequestModel.swift
//  AtchI
//
//  Created by 이봄이 on 2023/05/21.
//

import Foundation

struct QuizCheckRequestModel: Encodable {
    let tqid: Int
    let quizNum: Int
}
