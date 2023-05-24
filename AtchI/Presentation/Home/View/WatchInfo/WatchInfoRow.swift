//
//  WatchInfoRow.swift
//  AtchI
//
//  Created by 강민규 on 2023/03/23.
//

import SwiftUI

struct WatchInfoRow: View {
    var text: String
    var value: String
    
    var body: some View {
        HStack {
            Text(text)
            Spacer()
            Text(value)
        }
        .padding(.bottom,23)
    }
}
