//
//  AppTitleBar.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/03/13.
//

import SwiftUI

struct AppTitleBar: View {
    var body: some View {
        HStack{
            Image("logo_gray")
                .imageScale(.large)
            Text("엣치")
                .font(.bodyLarge)
                .foregroundColor(.grayTextLight)
        }
        .frame(maxWidth: .infinity,
                        maxHeight: .infinity,
                        alignment: .leading)
    }
}
