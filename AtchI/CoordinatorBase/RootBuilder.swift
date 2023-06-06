//
//  RootBuilder.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/06/06.
//

import Foundation
import SwiftUI

struct RootBuilder<Content: View>: View  {

    @State var path = NavigationPath()
    var content: (Binding<NavigationPath>) -> Content

    var body: some View {
        NavigationStack(path: $path) {
            ZStack {
                content($path)
            }
        }
    }
}
