//
//  RoundButton.swift
//  AtchI
//
//  Created by 이봄이 on 2023/03/20.
//

import SwiftUI

struct RoundButton: ButtonStyle {
    var labelColor = Color.white
    var backgroundColor = Color.blue
      
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.bodySmall)
            .foregroundColor(labelColor)
            .padding(EdgeInsets(top: 13, leading: 20, bottom: 13, trailing: 20))
            .background(Capsule().fill(backgroundColor))
      }
}
