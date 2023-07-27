//
//  Colors.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/03/09.
//

import Foundation
import SwiftUI

extension Color {
    static let mainPurple = Color("mainPurple")
    static let mainPurpleLight = Color("mainPurpleLight")
    static let mainBlue = Color( "mainBlue")
    static let mainBlueLight = Color("mainBlueLight")
    static let mainError = Color("mainError")
    static let mainComplete = Color("mainComplete")
    static let mainText = Color("mainText")
    static let mainBackground = Color("mainBackground")
    static let mainRed = Color("mainRed")
    static let mainRedLight = Color("mainRedLight")
    
    static let grayBoldLine = Color("grayBoldLine")
    static let grayThinLine = Color("grayThinLine")
    static let grayDisabled = Color("grayDisabled")
    static let grayTextLight = Color("grayTextLight")

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
