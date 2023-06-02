//
//  ModalDismissButton.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/06/02.
//

import SwiftUI

struct ModalDismissButton: View {
    var body: some View {
        VStack(alignment: .center) {
            Text("닫기")
                .font(.titleSmall)
                .foregroundColor(.mainPurple)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 65)
        .background(Color.mainPurpleLight)
        .cornerRadius(20)
    }
}

struct ModalDismissButton_Previews: PreviewProvider {
    static var previews: some View {
        ModalDismissButton()
    }
}
