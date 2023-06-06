//
//  Quiz.swift
//  AtchI
//
//  Created by 이봄이 on 2023/05/25.
//

import Foundation

struct Quiz: Decodable, Hashable {
    var index: Int?
    var content: String?
    var check: Bool?
    var solved: Bool?
}
