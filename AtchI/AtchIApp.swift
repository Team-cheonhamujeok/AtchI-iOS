//
//  AtchIApp.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/03/09.
//

import SwiftUI

@main
struct AtchIApp: App {
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
