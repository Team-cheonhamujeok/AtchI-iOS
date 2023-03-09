//
//  Colors.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/03/09.
//

import Foundation
import SwiftUI

extension Color {
    static let mainPurple = Color(hex: "7544C6")
    static let mainPurpleLight = Color(hex: "7544C6").opacity(0.2)
    static let mainBlue = Color(hex: "4478C6")
    static let mainBlueLight = Color(hex: "4478C6").opacity(0.2)
    static let mainError = Color(hex: "C64444")
    static let mainComplete = Color(hex: "50A343")
    static let mainText = Color(hex: "000000")
    
    static let grayBoldLine = Color(hex: "F5F5F5")
    static let grayThinLine = Color(hex: "D8D8D8")
    static let grayDisabled = Color(hex: "ABABAB")
    static let grayTextLight = Color(hex: "767676")

}

extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        _ = scanner.scanString("#")
        
        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)
        
        let r = Double((rgb >> 16) & 0xFF) / 255.0
        let g = Double((rgb >> 8) & 0xFF) / 255.0
        let b = Double((rgb >> 0) & 0xFF) / 255.0
        self.init(red: r, green: g, blue: b)
    }
}
