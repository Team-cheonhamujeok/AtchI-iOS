//
//  AppDelegate.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/05/16.
//

import Foundation
import UserNotifications
import UIKit

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        // 앱 실행 시 사용자에게 알림 허용 권한을 받음
        UNUserNotificationCenter.current().delegate = self
        
        PushNotificationHelper
            .shared
            .pushScheduledNotification(title: "오늘 퀴즈가 남아 있어요! ",
                                       body: "지금 바로 풀어보세요",
                                       hour: 12,
                                       identifier: "QUIZ_YET")
        PushNotificationHelper.shared.printPendingNotification()
        
        return true
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    
    func application(_ application: UIApplication,
                     didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
    }
    
    // 백그라운드에서 푸시 알림을 탭했을 때 실행됩니다.
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        // 퀴즈 안풀었을 시 퀴즈 탭으로 이동하게 딥링크 연결
        if response.notification.request.content.categoryIdentifier ==
            "GROUP_QUIZ_YET" {
            // TODO: quiz 개수 판단하는 로직 추가해야함
            let settingURL = URL(string: "atchi://prevent/")!
            if UIApplication.shared.canOpenURL(settingURL) {
                UIApplication.shared.open(settingURL)
            }
        }
        
        completionHandler()
    }
    
    // Foreground(앱 켜진 상태)에서 알림이 오면 실행됩니다.
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        // 햅틱을 실행하는 함수를 호출합니다.
        HapticHelper.shared.impact(style: .medium)
        completionHandler([.list, .banner, .sound])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                openSettingsFor notification: UNNotification?) {
        
        let settingURL = URL(string: "atchi://setting/")!
        if UIApplication.shared.canOpenURL(settingURL) {
            UIApplication.shared.open(settingURL)
        }
    }
}
