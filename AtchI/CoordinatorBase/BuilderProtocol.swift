//
//  BuilderProtocol.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/06/06.
//

import Foundation
import SwiftUI

protocol BuilderProtocol: View {
    associatedtype CoordinatorType = CoordinatorProtocol
    var coordinator: CoordinatorType { get set }
}


