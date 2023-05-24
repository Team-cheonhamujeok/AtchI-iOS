//
//  ReConnectCardView.swift
//  AtchI
//
//  Created by 강민규 on 2023/05/24.
//

import SwiftUI

/// 애플워치 미착용 상태 카드 뷰
struct ReConnectCardView: View {
    var viewModel: WatchInfoViewModel
    
    var body: some View {
        VStack(spacing: 7) {
            Spacer()
            Text("애플워치 미착용 상태입니다 🥲")
                .font(.titleSmall)
                .foregroundColor(.mainText)
            Text("애플워치를 착용해야 AI 진단이 가능합니다")
                .font(.bodySmall)
                .foregroundColor(.mainText)
            
            DefaultButton(buttonSize: .small,
                          width: 81,
                          height: 35,
                          buttonStyle: .filled,
                          buttonColor: .mainPurple,
                          isIndicate: false)
            {
                //TODO: Watch 연결 함수 넣기
                viewModel.isConnectedWatch = !viewModel.isConnectedWatch
            } content: {
                Text("재시도")
                    .font(.bodySmall)
            }
            .padding()
        }
        .padding(25)
        .frame(maxWidth: .infinity, maxHeight: 160)
        .background(Color.grayBoldLine)
        .cornerRadius(20)
        
    }
}


