//
//  RoundedButton.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/03/17.
//

import SwiftUI
import Combine

struct RoundedButton: View {
    let title: String
    var onTap: PassthroughSubject<Void, Never>? = nil
    var disabled: Bool = false
    var loading: Bool = true
    
    var body: some View {
        VStack {
            if loading {
                LottieView(lottieFile: "dots-loading",
                           loopMode: .loop)
                .frame(width: 150,
                       height: 65)
            }
            else {
                Text(title)
                    .foregroundColor(.white)
                    .font(.titleSmall)
            }
        }
        .frame(maxWidth: .infinity,
               minHeight: 65,
               maxHeight: 65)
        .background(backgroundColor)
        .cornerRadius(20)
        .disabled(disabled)
        .onTapGesture {
            onTap?.send()
        }.animation(.easeIn,
                    value: backgroundColor)
    }
    
    private var backgroundColor: Color {
        switch (disabled, loading) {
        case (true, _):
            return Color.grayDisabled
        case (_, true):
            return Color.mainPurpleLight
        case (_, _):
            return Color.mainPurple
        }
    }
}

struct RoundedButton_Previews: PreviewProvider {
    static var previews: some View {
        RoundedButton(title: "안녕")
    }
}


