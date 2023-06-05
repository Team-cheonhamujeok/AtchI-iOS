//
//  HomeCoordinator.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/06/06.
//

import Foundation
import SwiftUI

enum HomeLink: LinkProtocol {
    
    case mmse
    
    func matchView() -> any View {
        return MMSEView()
    }
}

class HomeCoordinator: CoordinatorProtocol {
    
    typealias LinkType = HomeLink
    
    @Binding var path: NavigationPath
    @Published var sheet: HomeLink?
    
    init(path: Binding<NavigationPath>) {
        _path = path
    }
}


struct HomeBuilder: BuilderProtocol  {
    typealias LinkType = HomeLink
    
//    @Binding var path: NavigationPath
    @ObservedObject var coordinator: HomeCoordinator
    
    var body: some View {
        HomeView(viewModel: HomeViewModel(coordinator: coordinator), predictVM: PredictionVM())
            .sheet(item: $coordinator.sheet) {_ in
                EmptyView()
            }
            .navigationDestination(for: LinkType.self) { link in
                MMSEBuilder()
            }
    }
}
