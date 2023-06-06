//
//  HomeCoordinator.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/06/06.
//

import Foundation
import SwiftUI

import StackCoordinator

class HomeCoordinator: CoordinatorProtocol {

    @Binding var path: NavigationPath
    @Published var sheet: HomeLink?
    
    required init(path: Binding<NavigationPath>) {
        _path = path
    }
}
