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
    
    case selfTest
    case selfTestInfo(_: SelfTestInfoViewModel)
    case mmseInfo(_: MMSEInfoViewModel)
    case mmse(_: BaseCoordinator<MMSELink>)
    
    
    func matchView() -> any View {
        switch self {
        case .selfTest:
            return SelfTestBuilder()
        case .selfTestInfo(let viewModel):
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
