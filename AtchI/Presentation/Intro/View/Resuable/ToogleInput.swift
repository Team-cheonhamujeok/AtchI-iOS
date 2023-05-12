//
//  ToogleInput.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/03/17.
//

import SwiftUI

struct ToogleInput: View {
    var title: String
    let options: [String]
    
    @Binding var selected: String
    
    var body: some View {
        VStack (alignment: .leading) {
            Text(title)
                .font(.bodyLarge)
            HStack (spacing: 0) {
                ForEach(options, id: \.self) { option in
                    Button(action: {
                        self.selected = option
                    }) {
                        Text(option)
                            .padding()
                            .foregroundColor(selected != option ? Color.accentColor : Color.white)
                            .font(.bodyMedium)
                            .frame(maxWidth: 65, minHeight: 65)
                    }
                    .frame(maxWidth: .infinity, minHeight: 65)
                    .background(selected == option ? Color.accentColor : Color.mainBackground)
                    .animation(.easeInOut(duration: 0.1), value: selected)
                }
            }
            .frame(maxWidth: .infinity,
                   minHeight: 65,
                   maxHeight: 65)
            .cornerRadius(20)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .strokeBorder(
                        Color.accentColor,
                        lineWidth: 2)
            )
        }
    }
}



