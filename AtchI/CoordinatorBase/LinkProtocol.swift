//
//  LinkProtocol.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/06/06.
//

import Foundation

protocol LinkProtocol: Hashable, Identifiable { }

extension LinkProtocol {
    var id: String {
        String(describing: self)
    }
}
