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
        NavigationView {
            VStack(alignment: .leading, spacing: 15) {
                Text("설정")
                    .font(.titleLarge)
                
                SettingCategoriesView()
                
                Spacer()
                Text("로그아웃하기")
                    .font(.bodySmall)
                    .foregroundColor(.grayTextLight)
                    .onTapGesture {
                        UserDefaults.standard.removeObject(forKey: "mid")
                    }
                    .frame(maxWidth: .infinity)
            }
            .padding(30)
            .background(Color.mainBackground)
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
