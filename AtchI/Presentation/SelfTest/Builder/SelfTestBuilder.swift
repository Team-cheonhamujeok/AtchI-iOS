//
//  SelfTestBuilder.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/06/14.
//

import Foundation
import SwiftUI

import StackCoordinator

struct SelfTestBuilder: BuilderProtocol {
    
    var coordinator = BaseCoordinator<SelfTestLink>()
    
    var body: some View {
        BaseBuilder(coordinator: coordinator) {
            SelfTestStartView(
                viewModel: SelfTestViewModel(
                    coordinator: coordinator
                )
            )
        }
    }
    
    
}
