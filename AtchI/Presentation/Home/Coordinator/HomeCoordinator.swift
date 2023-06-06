//
//  HomeCoordinator.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/06/06.
//

import Foundation
import SwiftUI

import StackCoordinator

enum HomeLink: LinkProtocol {
    
    case mmse
    
    func matchView() -> any View {
        return MMSEView()
    }
}

class HomeCoordinator: CoordinatorProtocol {

    @Binding var path: NavigationPath
    @Published var sheet: HomeLink?
    
    required init(path: Binding<NavigationPath>) {
        _path = path
    }
}

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
