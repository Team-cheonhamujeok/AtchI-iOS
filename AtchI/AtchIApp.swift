//
//  AtchIApp.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/03/09.
//

import SwiftUI
import LinkNavigator

@main
struct AtchIApp: App {
    let hkAuthorizationProvider = HKAuthorizationProvider()
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate
    
    var navigator: LinkNavigator {
        return appDelegate.navigator
    }
    
    var body: some Scene {
        WindowGroup {
            navigator
                .launch(paths: ["tabBar"],
                        items: [:])
                .ignoresSafeArea(edges: .all)
        }
    }
}
