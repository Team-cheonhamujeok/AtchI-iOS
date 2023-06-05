//
//  MMSECoordinator.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/06/06.
//

import Foundation
import SwiftUI

enum MMSELink: LinkProtocol {
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
