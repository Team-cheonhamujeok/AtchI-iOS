//
//  GetWeekQuizResponseModel.swift
//  AtchI
//
//  Created by 이봄이 on 2023/05/31.
//

import Foundation

struct GetWeekQuizResponseModel: Codable {
    let wqid: Int
    let mid: Int
    let startDate: String
    let mon: Bool
    let tue: Bool
    let wed: Bool
    let thu: Bool
    let fri: Bool
    let sat: Bool
    let sun: Bool
}
