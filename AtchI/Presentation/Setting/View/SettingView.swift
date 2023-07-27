//
//  SettingView.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/05/12.
//

import SwiftUI

import StackCoordinator

/// 임시로 만든 설정뷰입니다.
struct SettingView: View {
    var coordinator: BaseCoordinator<SettingLink>
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("설정")
                .font(.titleLarge)
            SettingListView(coordinator: coordinator)
            Spacer()
        }
        .padding(30)
        .background(Color.mainBackground)
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView(
            coordinator: BaseCoordinator()
        )
    }
}
