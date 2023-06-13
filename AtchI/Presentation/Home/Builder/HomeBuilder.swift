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
    
    var coordinator = BaseCoordinator<HomeLink>()
    
    var body: some View {
        BaseBuilder(coordinator: coordinator) {
            HomeView(viewModel: HomeViewModel(coordinator: coordinator),
                     predictVM: PredictionViewModel())
        }
    }
}
