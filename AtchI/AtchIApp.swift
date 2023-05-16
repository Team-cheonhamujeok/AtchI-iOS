//
//  AtchIApp.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/03/09.
//

import SwiftUI

@main
struct AtchIApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onOpenURL { url in // 딥링크로 들어오면 실행
                    print(url)
                    if (UserDefaults.standard.integer(forKey: "mid") != 0)  {
                        guard let deepLinkIdentifier = url.deepLinkIdentifier else {
                          return
                        }
                        
                    }
                }
        }
    }
}

