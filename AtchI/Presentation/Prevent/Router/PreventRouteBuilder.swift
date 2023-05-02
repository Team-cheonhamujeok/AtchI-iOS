//
//  PreventRouteBuilder.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/05/02.
//

import Foundation

import LinkNavigator
import SwiftUI

struct PreventRouteBuilder: RouteBuilder {
    
  var matchPath: String { "prevent" }

  var build: (LinkNavigatorType, [String: String], DependencyType) -> MatchingViewController? {
    { navigator, items, dependency in
        return WrappingController(matchPath: matchPath) {
            PreventView()
      }
    }
  }
}


