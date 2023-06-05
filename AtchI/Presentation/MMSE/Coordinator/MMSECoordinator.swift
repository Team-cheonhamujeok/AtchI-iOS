//
//  MMSECoordinator.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/06/06.
//

import Foundation
import SwiftUI

protocol CoordinatorProtocol: ObservableObject {
    associatedtype LinkType: LinkProtocol

    var link: LinkType? { get set }
    var path: NavigationPath { get set }
}

class CoordinatorPath {
    static let shared = CoordinatorPath()
    
    private init() { }
    
    var path: NavigationPath = NavigationPath()
}

//extension CoordinatorProtocol {
//    var path: NavigationPath {
//        get { return CoordinatorPath.shared.path } // 기본 값
//        set { /* 구현 내용 */ }
//    }
//}

class BaseCoordinator: ObservableObject {
    static let shared = BaseCoordinator()
    
    private init() { }
    
    @Published var path = NavigationPath()
}

enum MMSELink: LinkProtocol {
    func matchView() -> any View {
        return EmptyView()
    }
}

class MMSECoordinator {
    @Published var link: MMSELink?
    
    
}

struct MMSEBuilder: View  {
   
    @State var coordinator = MMSECoordinator()

    var body: some View {
            MMSEView()
        }
}
