//
//  HomeCoordinator.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/06/06.
//

import Foundation
import SwiftUI

import StackCoordinator


struct HomeBuilder: BuilderProtocol {
    
    var coordinator: HomeCoordinator
    
    var body: some View {
        ChildBuilder(coordinator: coordinator)
        {
            HomeView(viewModel: HomeViewModel(coordinator: coordinator),
                     predictVM: PredictionVM())
        }
    }
}
