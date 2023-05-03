//
//  AppDependency.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/05/02.
//

import LinkNavigator

/// 외부 의존성을 관리하는 타입입니다.
///
/// DependencyType 프로토콜을 채택해야 합니다.
class AppDependency: DependencyType {
    
//    // 싱글턴으로 사용
//    static let shared = AppDependency()
//    private init() {
//        navigator = LinkNavigator(dependency: PreviewDependency(),
//                                  builders: PreviewRouerGroup().routers)
//    }
//
//    var navigator: LinkNavigatorType? = nil
//
//    func resolve<T>() -> T? {
//        
//        print("###: \(T.self)")
//        print("###: \(LinkNavigatorType.self)")
//        print("###\(T.self == LinkNavigatorType.self)")
//        
//        print("###: \(T.self)")
//        print("###: \(PreventViewModel.self)")
//        print("###\(T.self == PreventViewModel.self)")
//
//        switch T.self {
//        case is LinkNavigator.Type:
//            return navigator as? T
//        case is PreventViewModel.Type:
//            return PreventViewModel(navigator: self.navigator!) as? T
//        default:
//            return navigator as? T
//        }
//    }
}

struct PreviewDependency: DependencyType { }

struct PreviewRouerGroup {
    var routers: [RouteBuilder] { [] }
}
