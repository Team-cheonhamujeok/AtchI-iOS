//
//  DiagnosisBuilder.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/06/07.
//

import Foundation
import SwiftUI

import StackCoordinator

struct DiagnosisBuilder: BuilderProtocol {
    
    var coordinator: BaseCoordinator<DiagnosisLink>
    
    var body: some View {
        BaseBuilder(coordinator: coordinator) {
            DiagnosisView(coordinator: coordinator)
        }
    }
}
