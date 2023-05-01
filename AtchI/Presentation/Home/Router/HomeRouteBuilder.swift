//
//  HomeRouteBuilder.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/05/02.
//

import Foundation

import LinkNavigator
import SwiftUI

struct HomeRouteBuilder: RouteBuilder {
    
  var matchPath: String { "home" }

  var build: (LinkNavigatorType, [String: String], DependencyType) -> MatchingViewController? {
    { navigator, items, dependency in
        return WrappingController(matchPath: matchPath) {
        HomeView(navigator: navigator)
      }
    }
  }
}
