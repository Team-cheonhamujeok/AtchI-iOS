//
//  View.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/03/17.
//

import SwiftUI

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}
