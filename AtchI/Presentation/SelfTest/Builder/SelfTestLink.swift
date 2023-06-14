//
//  SelfTestLink.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/06/14.
//

import Foundation
import SwiftUI

import StackCoordinator

enum SelfTestLink: LinkProtocol {
    
    case test(_: SelfTestViewModel)
    case result(_: SelfTestViewModel)
    
    func matchView() -> any View {
        switch self {
        case .test(let viewModel):
            return SelfTestView(
                selfTestViewModel: viewModel
            )
        case .result(let viewModel):
            return SelfTestResultView(
                selfTestViewModel: viewModel
            )
        }
    }
}
