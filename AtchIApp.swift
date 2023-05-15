//
//  AtchIApp.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/03/09.
//

import SwiftUI
import Firebase

@main
struct AtchIApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    let hkAuthorizationProvider = HKAuthorizationProvider()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear{
                    hkAuthorizationProvider.setAuthorization()
                }
        }
    }
}
