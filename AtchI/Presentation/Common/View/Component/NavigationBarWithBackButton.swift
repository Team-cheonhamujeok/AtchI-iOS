//
//  NavigationBarWithBackButton.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/05/23.
//

import SwiftUI

struct NavigationBarWithBackButton: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    var bgColor: Color
    
    var body: some View {
        Button(action: {
            presentationMode.wrappedValue.dismiss() // 백 버튼 액션
        }) {
            HStack {
                Image(systemName: "arrow.left")
                    .foregroundColor(bgColor == .white
                                     ? .accentColor
                                     : .white)
                Text("뒤로가기")
                    .font(.bodySmall)
                    .foregroundColor(bgColor == .white
                                     ? .accentColor
                                     : .white)
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .padding([.leading, .top, .bottom], 10)
        .background(bgColor == .white
                    ? .white
                    : .accentColor)
        .frame(maxWidth: .infinity)
    }
}
