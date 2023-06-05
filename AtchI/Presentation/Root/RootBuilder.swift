//
//  RootBuilder.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/06/06.
//

import Foundation
import SwiftUI

enum RootLink: LinkProtocol {
    
}

struct RootBuilder: BuilderProtocol  {
    typealias LinkType = RootLink
    
    @State var path = NavigationPath()

    var body: some View {
        NavigationStack(path: $path) {
            ZStack {
                RootView(path: $path)
            }
        }
    }
}
