//
//  MMSEResultStack.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/05/30.
//

import SwiftUI

struct MMSEResultStack: View {
    
    let resultScores: [String: String]
    
    var body: some View {
        VStack(spacing: 20) {
            Text("검사 결과")
                .font(.titleSmall)
            .foregroundColor(.mainText)
            Divider()
                .foregroundColor(.grayThinLine)
            
            ForEach(Array(resultScores), id: \.self.key) { title, score in
                VStack(spacing: 5) {
                    Text(title)
                        .font(.bodyMedium)
                        .fontWeight(.bold)
                        .foregroundColor(.grayTextLight)
                    Text(score)
                        .font(.bodyMedium)
                        .fontWeight(.bold)
                        .foregroundColor(.mainPurple)
                }
                .frame(maxWidth: .infinity)
                .padding(15)
                .background(Color.grayBoldLine)
                .cornerRadius(20)
            }
            
        }
    }
}

struct MMSEResultStack_Previews: PreviewProvider {
    static var previews: some View {
        MMSEResultStack(resultScores: [:])
    }
}
