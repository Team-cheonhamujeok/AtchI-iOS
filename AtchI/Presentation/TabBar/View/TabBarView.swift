//
//  TabBarView.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/05/02.
//

import SwiftUI

struct TabBarView: View {
    
    
    var body: some View {
        TabView {
            HomeView()
                .tabItem{
                    Image(systemName: "house")
                    Text("홈")
                }
            Text("임시")
//            PreventView(preventViewModel: PreventViewModel())
                .tabItem{
                    Image(systemName: "brain.head.profile")
                    Text("예방")
                }
            LoginView()
                .tabItem{
                    Image(systemName: "square.and.pencil")
                    Text("글쓰기")
                }
            SignupView()
                .tabItem{
                    Image(systemName: "gear")
                    Text("설정")
                }
            Text("설정")
                .tabItem{
                    Image(systemName: "gear")
                    Text("설정")
                }
        }
    }
}


struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
