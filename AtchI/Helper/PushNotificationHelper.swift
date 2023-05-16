//
//  PushNotificationHelper.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/05/16.
//

import Foundation
import UserNotifications
import UIKit

class PushNotificationHelper {
    static let shared = PushNotificationHelper()
    
    private init() {}
    
    func setAuthorization() {
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound, .provisional] // 필요한 알림 권한을 설정
        UNUserNotificationCenter.current().requestAuthorization(
            options: authOptions,
            completionHandler: { _, _ in }
        )
    }
    
    func pushNotification(title: String, body: String, seconds: Double, identifier: String) {

        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = title
        notificationContent.body = body

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: seconds, repeats: false)
        
        let request = UNNotificationRequest(identifier: identifier,
                                            content: notificationContent,
                                            trigger: trigger)

        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Notification Error: ", error)
            }
        }
    }
}
