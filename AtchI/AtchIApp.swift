//
//  AtchIApp.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/03/09.
//

import SwiftUI

@main
struct AtchIApp: App {
    
    let service = HealthKitService()
    
    var body: some Scene {
        WindowGroup {
            SleepTimeView()
        }
    }
    
    init() {
        setup()
    }
    
    func setup() {
        // 첫 실행 시 실행할 코드를 여기에 작성합니다.
        service.configure()
    }
}
