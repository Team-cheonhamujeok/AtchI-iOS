//
//  TabBarView.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/05/02.
//

import SwiftUI
import LinkNavigator

struct TabBarView: View {
    
    var body: some View {
        TabView {
            HomeView()
                .tabItem{
                    Image(systemName: "house")
                    Text("home")
                }
            Text("Page 2")
//            PreventView(preventViewModel: PreventViewModel())
                .tabItem{
                    Image(systemName: "brain.head.profile")
                    Text("second")
                }
            Text("Page 3")
                .tabItem{
                    Image(systemName: "square.and.pencil")
                    Text("글쓰기")
                }
            Text("Page 4")
                .tabItem{
                    Image(systemName: "gear")
                    Text("설정")
                }
            Text("Page 5")
                .tabItem{
                    Image(systemName: "gear")
                    Text("설정")
                }
        }
        .toolbar(content: {
            ToolbarItemGroup(placement: .navigationBarLeading) {
                AppTitleBar().padding()
            }
        })
    }
}


//struct TabBarView_Previews: PreviewProvider {
//    static var previews: some View {
//        TabBarView(navigator: LinkNavigator(dependency: AppDependency(), builders: AppRouterGroup().routers))
//    }
//}
