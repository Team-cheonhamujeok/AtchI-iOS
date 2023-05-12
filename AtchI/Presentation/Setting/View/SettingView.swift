//
//  SettingView.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/05/12.
//

import SwiftUI

/// 임시로 만든 설정뷰입니다.
struct SettingView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("설정")
                .font(.titleLarge)
            Spacer(minLength: 15)
            
            VStack(alignment: .leading, spacing: 15) {
                HStack {
                    Text("개인정보")
                        .font(.titleSmall)
                    Spacer()
                    Image("arrow-right")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 10)
                }
                Divider()
                HStack {
                    Text("개인정보 이용약관")
                        .font(.titleSmall)
                    Spacer()
                    Image("arrow-right")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 10)
                }
                Divider()
                Spacer()
            }
            Spacer()
        }
        .padding(30)
        .background(Color.mainBackground)
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
