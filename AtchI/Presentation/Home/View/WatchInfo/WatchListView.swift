//
//  WatchListView.swift
//  AtchI
//
//  Created by 강민규 on 2023/05/24.
//

import SwiftUI

/// 애플워치 데이터 리스트 뷰
struct WatchListView: View {
    var viewModel: WatchInfoViewModel
    var body: some View {
        VStack {
            WatchInfoRow(text: "👟 걸음수", value: viewModel.getWalk())
            WatchInfoRow(text: "❤️ 심박 평균", value: viewModel.getHeart())
            WatchInfoRow(text: "💤 수면 시간", value: viewModel.getSleep())
        }
    }
}
