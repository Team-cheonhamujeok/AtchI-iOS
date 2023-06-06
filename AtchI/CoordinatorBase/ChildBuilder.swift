//
//  BaseBuilder.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/06/06.
//

import Foundation
import SwiftUI

struct ChildBuilder<Content: View, Coordinator: CoordinatorProtocol>: BuilderProtocol {
    @ObservedObject var coordinator: Coordinator
//    var destination: (Coordinator.LinkType) -> any View
//    var sheetDestination: (Coordinator.LinkType) -> any View
    
    var content: () -> Content
    
//    init(coordinator: Coordinator,
//         @ViewBuilder destination: @escaping (Coordinator.LinkType) -> any View,
//         @ViewBuilder content: @escaping () -> Content) {
//        self.coordinator = coordinator
//        self.destination = destination
//        self.sheetDestination = destination
//        self.content = content
//    }
//    
//    init(coordinator: Coordinator,
//         @ViewBuilder destination: @escaping (Coordinator.LinkType) -> any View,
//         @ViewBuilder sheetDestination: @escaping (Coordinator.LinkType) -> any View,
//         @ViewBuilder content: @escaping () -> Content) {
//        self.coordinator = coordinator
//        self.destination = destination
//        self.sheetDestination = sheetDestination
//        self.content = content
//    }
    
    var body: some View {
        content()
            .sheet(item: $coordinator.sheet) { link in
                AnyView(link.matchView())
            }
            .navigationDestination(for: Coordinator.LinkType.self) { link in
                AnyView(link.matchView())
            }
    }
}
