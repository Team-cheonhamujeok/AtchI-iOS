//
//  RouteBuilder.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/05/02.
//

import Foundation

import LinkNavigator
import SwiftUI

struct RootRouteBuilder: RouteBuilder {
    
  var matchPath: String { "root" }

  var build: (LinkNavigatorType, [String: String], DependencyType) -> MatchingViewController? {
    { navigator, items, dependency in
        return WrappingController(matchPath: matchPath) {
        RootView(navigator: navigator)
      }
    }
  }
}

