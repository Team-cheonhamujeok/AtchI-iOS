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
        appDelegate.navigator
    }
    
    var body: some Scene {
        WindowGroup {
            navigator
                    .launch(paths: ["home"], items: [:]) // 'paths' 파라미터의 인자가 시작 페이지로 설정됩니다.
//            ContentView()
//                .onAppear{
//                    hkAuthorizationProvider.setAuthorization()
//            }
        }
    }
}
