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
    
    @State private var selected: String
    
    init(title: String, options: [String]) {
        self.title = title
        self.options = options
        self.selected = options[0]
    }
    
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
                            .foregroundColor(selected != option ? Color.mainPurple : Color.white)
                            .font(.bodyMedium)
                            .frame(maxWidth: 65, minHeight: 65)
                    }
                    .frame(maxWidth: .infinity, minHeight: 65)
                    .background(selected == option ? Color.mainPurple : Color.white)
                    .animation(.easeInOut(duration: 0.1))
                }
            }
            .frame(maxWidth: .infinity,
                   minHeight: 65,
                   maxHeight: 65)
            .cornerRadius(20)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .strokeBorder(
                        Color.mainPurple,
                        lineWidth: 2)
            )
        }
        Spacer(minLength: 15)
    }
}



