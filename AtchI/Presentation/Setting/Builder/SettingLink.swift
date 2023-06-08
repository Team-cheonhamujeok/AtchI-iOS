//
//  SettingLink.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/06/09.
//

import Foundation
import SwiftUI

import StackCoordinator

enum SettingLink: LinkProtocol, CaseIterable {
    
    case profile
    case privacyPolicy
    
    func matchView() -> any View {
        switch self {
        case .profile:
            return ProfileSettingView()
        case .privacyPolicy:
            return PrivacyPolicyView()
        }
    }
    
    var title: String {
        switch self {
        case .profile: return "개인정보"
        case .privacyPolicy: return "개인정보 이용약관"
        }
    }
}
