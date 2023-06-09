//
//  ContentView.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/03/09.
//
import SwiftUI
import UIKit

import Moya
import StackCoordinator

struct ContentView: View {
    
    @AppStorage("mid") private var mid: Int = 0
    
    @Environment(\.colorScheme) var colorScheme
    
    @State private var selectedTab: TabBarType = .home
    
    @Binding var path: NavigationPath
    
    var body: some View {
        let isIntroModalOpen = Binding<Bool>(
            get: { mid == 0 },
            set: { _ in }
        )
        TabView(selection: $selectedTab) {
            HomeBuilder()
            .tabItem{
                Image(systemName: "house")
                Text("홈")
            }
            .tag(TabBarType.home)
            DiagnosisBuilder(
                coordinator: BaseCoordinator<DiagnosisLink>()
            )
            .tabItem{
                Image(systemName: "stethoscope")
                Text("진단")
            }
            .tag(TabBarType.diagnosis)
            PreventBuilder(coordinator: BaseCoordinator<PreventLink>())
                .tabItem{
                    Image(systemName: "brain.head.profile")
                    Text("예방")
                }
                .tag(TabBarType.prevent)
            SettingBuilder(
                coordinator: BaseCoordinator<SettingLink>()
            )
            .tabItem{
                Image(systemName: "gear")
                Text("설정")
            }
            .tag(TabBarType.setting)
            
        }
        .tabViewStyle(DefaultTabViewStyle())
        .toolbar(.hidden, for: .navigationBar)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear() {
            // Setting tabView style
            UITabBar.appearance().standardAppearance = setTabBarAppearance()
            UITabBar.appearance().barTintColor = UIColor(Color.mainBackground)
            UITabBar.appearance().backgroundColor = UIColor(Color.mainBackground)
            UINavigationBar.appearance().backItem?.titleView?.tintColor = .white
        }
        .fullScreenCover(isPresented: isIntroModalOpen) {
            IntroView()
        }
        .onOpenURL { url in // 딥링크로 들어오면 실행
            if (UserDefaults.standard.integer(forKey: "mid") != 0)  {
                if let mappedTab = url.deepLinkHostMapTabBar {
                    selectedTab = mappedTab
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(path: .constant(NavigationPath()))
    }
}

// MARK: - Setting tab view style extension

extension ContentView {
    // 보더 설정 appearance 세팅
    func setTabBarAppearance() -> UITabBarAppearance {
        let image = UIImage
            .borderImageWithBounds(
                bounds: CGRect(
                    x: 0,
                    y: 0,
                    width: UIScreen.main.scale,
                    height: 0.5
                ),
                color: UIColor(Color.gray),
                thickness: 0.5)
        
        let appearance = UITabBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = UIColor(Color.mainBackground)
        
        appearance.backgroundImage = UIImage()
        appearance.shadowImage = image
        
        return appearance
    }
}



