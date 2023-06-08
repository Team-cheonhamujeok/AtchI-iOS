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
    
    case selfTestStart(_: SelfTestViewModel, _: SelfTestInfoViewModel)
    case selfTest(_: SelfTestViewModel, _: SelfTestInfoViewModel)
    case selfTestResult(_: SelfTestViewModel, _: SelfTestInfoViewModel)
    case selfTestResultList(_: SelfTestInfoViewModel)
    case mmseInfo(_: MMSEInfoViewModel)
    case mmse(_: BaseCoordinator<MMSELink>)
    
    
    func matchView() -> any View {
        switch self {
        case .selfTestStart(let viewModel, let infoVM):
            return SelfTestStartView(
                viewModel: viewModel, selfTestInfo: infoVM
            )
        case .selfTest(let viewModel, let infoVM):
            return SelfTestView(
                selfTestViewModel: viewModel, selfTestInfoViewModel: infoVM
            )
        case .selfTestResult(let viewModel, let infoVM):
            return SelfTestResultView(selfTestViewModel: viewModel, selfTestInfoViewModel: infoVM)
        case .selfTestResultList(let viewModel):
            return SelfTestResultList(selfTestInfoViewModel: viewModel)
        case .mmseInfo(let viewModel):
            return MMSEResultList(mmseInfoViewModel: viewModel)
        case .mmse(let coordinator):
            return MMSEBuilder(coordinator: coordinator)
        }
    }
}
//

extension DiagnosisLink: Equatable, Hashable {
    static func == (lhs: DiagnosisLink, rhs: DiagnosisLink) -> Bool {
        return lhs.id == rhs.id ? true : false
    }
    func hash(into hasher: inout Hasher) {
    }

    var id: String {
        String(describing: self)
    }
}

//extension MMSECoordinator: Hashable {
//    static func == (lhs: any CoordinatorProtocol, rhs: any CoordinatorProtocol) -> Bool {
//        return lhs.id == rhs.id ? true : false
//    }
//
//    func hash(into hasher: inout Hasher) {
//    }
//
//    var id: String {
//        String(describing: self)
//    }
//}