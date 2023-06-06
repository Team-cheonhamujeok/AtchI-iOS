//
//  MMSELink.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/06/07.
//

import Foundation
import SwiftUI

import StackCoordinator
import Moya

enum MMSELink: LinkProtocol {
    
    case result(_ score: [String: String])
    
    func matchView() -> any View {
        switch self {
        case .result(let score):
            return MMSEResultView(resultScores: score)
        }
    }
}
