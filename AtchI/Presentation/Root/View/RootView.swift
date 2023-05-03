//
//  TabBarView.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/05/02.
//

import SwiftUI
import LinkNavigator

struct RootView: View {
    
    let navigator: LinkNavigatorType
    
    var body: some View {
        TabView {
            HomeView(navigator: navigator)
                .tabItem{
                    Image(systemName: "house")
                    Text("홈")
                }
            DiagnosisView()
                .tabItem{
                    Image(systemName: "stethoscope")
                    Text("진단")
                }
            PreventView(preventViewModel: PreventViewModel(navigator: navigator))
                .tabItem{
                    Image(systemName: "brain.head.profile")
                    Text("예방")
                }
            Text("설정 부분")
                .tabItem{
                    Image(systemName: "gear")
                    Text("설정")
                }
        }
        .toolbar(content: {
            ToolbarItemGroup(placement: .navigationBarLeading) {
                AppTitleBar()
            }
        })
    }
}


struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        RootView(navigator: LinkNavigator(dependency: AppDependency(), builders: AppRouterGroup().routers))
    }
}
