//
//  PredictionResponse.swift
//  AtchI
//
//  Created by 강민규 on 2023/06/05.
//

import Foundation

struct PredictionResponse: Codable {
    let success: Bool
    let response: [PredictionModel]
    let error: String
}
