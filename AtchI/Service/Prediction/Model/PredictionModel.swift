//
//  PredictionModel.swift
//  AtchI
//
//  Created by 강민규 on 2023/06/05.
//

import Foundation

struct PredictionModel: Codable {
    let pid: Int
    let mid: Int
    let startDate: String
    let endDate: String
    let notDementia: Double
    let beforeDementia: Double
    let dementia: Double
}
