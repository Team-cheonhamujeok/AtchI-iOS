//
//  Devider.swift
//  AtchI
//
//  Created by 이봄이 on 2023/03/19.
//

import SwiftUI

struct BoldDivider: View {
    var body: some View {
        Rectangle()
            .fill(Color.grayBoldLine)
            .frame(height: 15)
            .edgesIgnoringSafeArea(.horizontal)
    }
}

struct BoldDivider_Previews: PreviewProvider {
    static var previews: some View {
        BoldDivider()
    }
}
