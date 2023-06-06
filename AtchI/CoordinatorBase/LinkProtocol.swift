//
//  LinkProtocol.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/06/06.
//

import Foundation
import SwiftUI

protocol LinkProtocol: Hashable, Identifiable {
    func matchView() -> any View
}

extension LinkProtocol {
    var id: String {
        String(describing: self)
    }
}
