//
//  MMSESaveRequestModel.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/05/30.
//

import Foundation

struct MMSESaveRequestModel: Codable{
    let mid: Int
    let questions: [String]
    let date: String
}
