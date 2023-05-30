//
//  MMSEViewType.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/05/26.
//

import Foundation

enum MMSEViewType: Equatable {
    
    case reply(Reply)
    case arithmetic(Arithmetic)
    case show(Show)
    case image(Image)
    case undefined
    
    enum Reply: String, CaseIterable {
        case year
        case day
        case week
        case month
        case country
        case city
        case airplane
        case pencil
        case tree
    }
    
    enum Arithmetic: String, CaseIterable {
        case subtraction
    }
    
    enum Show: String, CaseIterable {
        case airplane
        case pencil
        case tree
    }
    
    enum Image: String, CaseIterable {
        case clock
        case ball
    }
}
