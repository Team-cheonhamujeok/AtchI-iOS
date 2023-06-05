//
//  RootBuilder.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/06/06.
//

import Foundation
import SwiftUI

struct RootBuilder: View  {

    @State var path = NavigationPath()

    var body: some View {
        NavigationStack(path: $path) {
            ZStack {
                RootView(path: $path)
            }
        }
    }
}
