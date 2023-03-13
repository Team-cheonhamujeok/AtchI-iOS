//
//  SelfDiagnosisShortcutCard.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/03/13.
//

import Foundation

import SwiftUI

struct SelfDiagnosisShortcutCard: View {
    var body: some View {
        ShortcutCard(
            title: "자가진단",
            content: "혹시 치매일까\n의심된다면")
    }
}

struct SelfDiagnosisShortcutCard_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
