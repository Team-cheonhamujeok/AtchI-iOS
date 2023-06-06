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
    
    var coordinator: DiagnosisCoordinator
    
    var body: some View {
        ChildBuilder(coordinator: coordinator)
        {
            DiagnosisView(coordinator: coordinator)
        }
    }
}
