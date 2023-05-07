//
//  ShortcutCard.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/03/13.
//

import SwiftUI


struct ShortcutCard: View {
    var title: String
    var content: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(title)
                .font(.titleMedium)
                .foregroundColor(.mainPurple)
            Text(content)
                .font(.bodySmall)
                .foregroundColor(.mainText)
            Spacer(minLength: 10)
            HStack {
                Text("바로가기")
                    .font(.bodyLarge)
                .foregroundColor(.mainText)
                Image(systemName: "arrow.forward").foregroundColor(.mainText)
            }
        }
        .padding(25)
        .frame(maxWidth: .infinity,
               maxHeight: .infinity,
               alignment: .leading)
        .background(Color.mainPurpleLight)
        .cornerRadius(20)
    }
}
