//
//  AtchIApp.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/03/09.
//

import SwiftUI

import Network

@main
struct AtchIApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            if NetworkMonitor.shared.isConnected {
                ContentView()
            } else {
                NetworkErrorView()
            }
        }
    }
}

