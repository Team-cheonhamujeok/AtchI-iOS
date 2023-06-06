//
//  DiagnosisLink.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/06/07.
//

import Foundation
import SwiftUI

import StackCoordinator
import Moya

enum DiagnosisLink: LinkProtocol {
    
    case selfTestStart(_: SelfTestViewModel)
    case selfTest(_: SelfTestViewModel)
    case selfTestResult(_: SelfTestViewModel)
    case mmse
    
    func matchView() -> any View {
        switch self {
        case .selfTestStart(let viewModel):
            return SelfTestStartView(
                viewModel: viewModel
            )
        case .selfTest(let viewModel):
            return SelfTestView(
                selfTestViewModel: viewModel
            )
        case .selfTestResult(let viewModel):
            return SelfTestResultView(selfTestViewModel: viewModel)
        case .mmse:
            return MMSEView()
        }
    }
}
