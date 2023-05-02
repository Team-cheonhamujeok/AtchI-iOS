//
//  AppDependency.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/05/02.
//

import LinkNavigator

protocol AppDependencyType: DependencyType {
    var navigator: LinkNavigatorType? { get set }
}

/// 외부 의존성을 관리하는 타입입니다.
///
/// DependencyType 프로토콜을 채택해야 합니다.
class AppDependency: DependencyType {
    
    // 싱글턴으로 사용
//    static let shared = AppDependency()
//    private init() {}
//
//    var navigator: LinkNavigatorType? = nil
//
//    func resolve<T>() -> T? {
//        switch T.self {
//        case is PreventViewModel.Type:
//            return PreventViewModel(navigator: self.navigator!) as? T
//        default:
//            return nil
//        }
//    }
}

//class PreviewDependency: AppDependencyType {
//    
//    // 싱글턴으로 사용
//    static let shared = PreviewDependency()
//    private init() {
//        let appDependency = AppDependency.shared
//        let linkNavigator = LinkNavigator(dependency: appDependency,
//                                          builders: AppRouterGroup().routers)
//        appDependency.navigator = linkNavigator
//        
//        self.navigator = linkNavigator
//    }
//    
//    var navigator: LinkNavigatorType?
//}


