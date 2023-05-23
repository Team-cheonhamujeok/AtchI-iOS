//
//  ExplainWatchView.swift
//  AtchI
//
//  Created by 강민규 on 2023/05/24.
//

import SwiftUI

/// 애플워치 설명 View
struct ExplainWatchView: View {
    @Binding var isConnected: Bool
    
    var body: some View {
        if isConnected {
            VStack(alignment: .leading) {
                HStack {
                    Text("현재 활동 정보")
                        .font(.titleMedium)
                    Spacer()
                }
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
                Text("AI 진단에 쓰이고 있는 활동 정보들입니다.")
                    .font(.bodySmall)
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
            }
        } else {
            HStack {
                VStack(alignment: .leading) {
                    Text("애플워치가 있으신가요?")
                        .font(.titleMedium)
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
                    Text("인공지능이 활동 정보를 바탕으로 진단을 해줘요")
                        .font(.bodySmall)
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
                }
                Spacer()
            }
        }
    }
}

