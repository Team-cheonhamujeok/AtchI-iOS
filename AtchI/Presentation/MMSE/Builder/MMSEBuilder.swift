//
//  MMSEBuilder.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/06/07.
//

import Foundation
import SwiftUI

import StackCoordinator

struct MMSEBuilder: BuilderProtocol {
    
    var coordinator: BaseCoordinator<MMSELink>
    
    var body: some View {
        BaseBuilder(coordinator: coordinator) {
            MMSEView(
                viewModel: MMSEViewModel(
                    coordinator: coordinator
                )
            )
        }
    }
}
