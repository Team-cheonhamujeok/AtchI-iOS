//
//  WatchActivityView.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/05/21.
//

import Foundation
import SwiftUI

struct WatchActivityView: View {
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack {
                Text("👟 걸음수")
                Spacer()
                Text("value")
            }
            HStack {
                Text("❤️ 심박평균")
                Spacer()
                Text("value")
            }
            HStack {
                Text("💤 수면시간")
                Spacer()
                Text("value")
            }
        }
    }
}
