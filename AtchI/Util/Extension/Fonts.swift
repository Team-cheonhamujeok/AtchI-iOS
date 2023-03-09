//
//  FontStyle.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/03/09.
//

import Foundation
import SwiftUI

extension Font {
    static let titleLarge: Font = system(size: 34, weight: .bold)
    static let titleMedium: Font = system(size: 22, weight: .semibold)
    static let titleSmall: Font = system(size: 20, weight: .semibold)
    
    static let bodyLarge: Font = system(size: 18, weight: .semibold)
    static let bodyMedium: Font = system(size: 18, weight: .regular)
    static let bodySmall: Font = system(size: 16, weight: .regular)
    static let bodyTiny: Font = system(size: 14, weight: .medium)
}
