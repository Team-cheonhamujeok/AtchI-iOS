//
//  AppDelegate.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/05/02.
//

import SwiftUI
import LinkNavigator

/// 외부 의존성과 화면을 주입받은 navigator 를 관리하는 타입입니다.
final class AppDelegate: NSObject {
  var navigator: LinkNavigator {
      let appDependency = AppDependency.shared
      let linkNavigator = LinkNavigator(dependency: appDependency,
                                        builders: AppRouterGroup().routers)
      appDependency.navigator = linkNavigator
      return linkNavigator
      
  }
}

extension AppDelegate: UIApplicationDelegate {
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
    true
  }
}
