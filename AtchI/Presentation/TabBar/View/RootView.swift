//
//  RootView.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/05/02.
//

import SwiftUI
import LinkNavigator

struct RootView: View {
    
    let navigator: LinkNavigatorType
    
    init(dependency: AppDependencyType = AppDependency.shared) {
        self.navigator = dependency.navigator!
    }
    
    var body: some View {
        EmptyView()
            .onAppear {
                navigator.fullSheet(paths: ["tabBar"],
                                    items: [:],
                                    isAnimated: false,
                                    prefersLargeTitles: false)
            }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
