//
//  SettingBuilder.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/06/09.
//

import Foundation
import SwiftUI

import StackCoordinator

struct SettingBuilder: BuilderProtocol {
    
    var coordinator: BaseCoordinator<SettingLink>
    
    var body: some View {
        BaseBuilder(coordinator: coordinator) {
            SettingView(coordinator: coordinator)
        }
    }
}
