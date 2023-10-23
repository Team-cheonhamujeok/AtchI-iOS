//
//  AppDelegate.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/05/16.
//

import Foundation
import UserNotifications
import UIKit
import HealthKit
import Combine

class AppDelegate: NSObject, UIApplicationDelegate {
    
    let store = HKHealthStore()
    var lifePatternService: LifePatternServiceType? = nil
    
    var cancellable = Set<AnyCancellable>()
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        UNUserNotificationCenter.current().delegate = self
        
        // MARK: Setting Push Notification
        PushNotificationHelper
            .shared
            .pushScheduledNotification(title: "오늘의 퀴즈를 풀어보세요",
                                       body: "뇌훈련을 위한 퀴즈가 준비되어 있어요!",
                                       hour: 12,
                                       identifier: "QUIZ_YET_DAY")
        
        PushNotificationHelper
            .shared
            .pushScheduledNotification(title: "오늘 퀴즈 다 푸셨나요?",
                                       body: "아직 퀴즈를 풀지 않았다면 지금 바로 풀어보세요!",
                                       hour: 19,
                                       identifier: "QUIZ_YET_NIGHT")

        // MARK: Setting SaveLifePattern
#if targetEnvironment(simulator)
#else
        lifePatternService = LifePatternService()
        let mid = UserDefaults.standard.integer(forKey: "mid")
        if mid != 0, let service = lifePatternService {
            service
                .requestLastDate(mid: mid)
                .flatMap { responseModel in
                    return service
                        .requestSaveLifePatterns(lastDate: responseModel.response.lastDate)
                }
                .sink(receiveCompletion: { completion in
                    print(completion)
                }, receiveValue: { result in
                    
                })
                .store(in: &cancellable)
        }
        lifePatternService = nil
#endif

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
        // FIXME: (작동안함) 퀴즈 탭으로 이동하게 딥링크 연결
        if ["GROUP_QUIZ_YET_NIGHT", "GROUP_QUIZ_YET_NIGHT" ].contains(response.notification.request.content.categoryIdentifier) {
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
