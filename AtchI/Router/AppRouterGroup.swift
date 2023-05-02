//
//  AppRouterGroup.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/05/02.
//

import LinkNavigator

/// LinkNavigator 를 통해 이동하고 싶은 화면들을 관리하는 타입입니다.
struct AppRouterGroup {
  var routers: [RouteBuilder] {
    [
//        RootRouteBuilder(),
        TabBarRouteBuilder(),
        HomeRouteBuilder(),
        PreventRouteBuilder(),
    ]
  }
}
