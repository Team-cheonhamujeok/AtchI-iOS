//
//  SelfTestResult.swift
//  AtchI
//
//  Created by 강민규 on 2023/03/21.
//

import Foundation

struct SelfTestResult: Identifiable {
    var id = UUID()
    var day: String
    var point: Int
    var level: String
}
