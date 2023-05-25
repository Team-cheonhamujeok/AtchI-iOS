//
//  RoundedButton.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/03/17.
//

import SwiftUI
import Combine

enum ButtonState {
    case enabled
    case disabled
    case loading
}

struct RoundedButton: View {
    let title: String
    var onTap: PassthroughSubject<Void, Never>? = nil
    var state: ButtonState

    var body: some View {
        VStack {
            if state == ButtonState.loading {
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
        .background(bgColor)
        .cornerRadius(20)
        .onTapGesture {
            if self.state != .disabled { onTap?.send() }
        }.animation(.easeIn,
                    value: state)
    }
    
    var bgColor: Color {
        switch state {
        case .enabled:
            return .accentColor
        case .disabled:
            return .grayDisabled
        case .loading:
            return .mainPurpleLight
        }
    }
}

struct RoundedButton_Previews: PreviewProvider {
    static var previews: some View {
        RoundedButton(title: "안녕", state: .disabled)
    }
}


