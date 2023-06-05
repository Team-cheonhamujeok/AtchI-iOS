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
    @Binding var path: NavigationPath
    var link: HomeLink?
    
    init(path: Binding<NavigationPath>) {
        _path = path
    }
}


struct HomeBuilder: BuilderProtocol  {
    typealias LinkType = HomeLink
    
    @Binding var path: NavigationPath
    
    var body: some View {
        HomeView(viewModel: HomeViewModel(path: $path), predictVM: PredictionVM())
            .navigationDestination(for: LinkType.self) { link in
                MMSEBuilder()
            }
    }
}
