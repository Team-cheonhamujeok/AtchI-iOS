//
//  HomeLink.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/06/06.
//

import Foundation
import SwiftUI

import StackCoordinator
import Moya

enum HomeLink: LinkProtocol {
    
    case mmse
    case healthInfo
    
    func matchView() -> any View {
        switch self {
        case .mmse : return MMSEView()
        case .healthInfo: return HealthInfoView()
        }
    }
}
