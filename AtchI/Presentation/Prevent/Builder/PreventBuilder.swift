//
//  PreventBuilder.swift
//  AtchI
//
//  Created by 이봄이 on 2023/06/09.
//

import Foundation
import SwiftUI

import StackCoordinator

struct PreventBuilder: BuilderProtocol {
    
    var coordinator: BaseCoordinator<PreventLink>
    
    var body: some View {
        BaseBuilder(coordinator: coordinator) {
            PreventView(
                coordinator: coordinator
            )
        }
    }
    
    
}
