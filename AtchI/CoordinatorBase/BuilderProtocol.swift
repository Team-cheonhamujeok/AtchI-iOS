//
//  BuilderProtocol.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/06/06.
//

import Foundation
import SwiftUI

protocol BuilderProtocol: View {
    associatedtype LinkType: LinkProtocol // 링크 구현 강제하기
    
    var path: NavigationPath { get set }
}
