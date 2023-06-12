//
//  BoldDivider.swift
//  AtchI
//
//  Created by 이봄이 on 2023/03/27.
//

import Foundation
import SwiftUI

struct BoldDivider: View {
    var body: some View {
        Rectangle()
            .fill(Color.grayBoldLine)
            .frame(height: 12)
            .edgesIgnoringSafeArea(.horizontal)
    }
}
