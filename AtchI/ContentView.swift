//
//  ContentView.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/03/09.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        // dy TODO: TabBar 커스텀 해야함
        TabView {
            //2. 여기에tabview안에 subview를 만들어주시면 됩니다.
            HomeView()
                .tabItem{
                    Image(systemName: "house")
                    Text("홈")
                }
            PreventView()
                .tabItem{
                    Image(systemName: "brain.head.profile")
                    Text("예방")
                }
            Text("설정")
                .tabItem{
                    Image(systemName: "gear")
                    Text("설정")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
