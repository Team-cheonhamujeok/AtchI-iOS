//
//  WatchInfoView.swift
//  AtchI
//
//  Created by 강민규 on 2023/03/21.
//

import SwiftUI

struct WatchInfoView: View {
    @StateObject var viewModel: WatchInfoViewModel
    
    //MARK: - Body
    var body: some View {
        if viewModel.isConnectedWatch {
            haveWatchView
        } else {
            noWatchView
        }
    }
    
    //MARK: - 애플워치가 등록되었을 때
    var haveWatchView: some View {
        VStack {
            ExplainWatchView(isConnected: $viewModel.isConnectedWatch)
                .padding(.bottom, 21)
            WatchListView(viewModel: viewModel)
        }
    }
    
    //MARK: - 애플워치가 등록안되었을 때
    var noWatchView: some View {
        VStack {
            ExplainWatchView(isConnected: $viewModel.isConnectedWatch)
            ReConnectCardView()
        }
    }
}

//MARK: - Other View
/// 애플워치 설명 View
struct ExplainWatchView: View {
    @Binding var isConnected: Bool
    
    var body: some View {
        if isConnected {
            VStack(alignment: .leading) {
                HStack {
                    Text("애플워치 연결 상태")
                        .font(.titleMedium)
                    Spacer()
                    Text("연결됨")
                        .font(.titleSmall)
                        .foregroundColor(.mainComplete)
                }
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
                Text("인공지능이 모으고 있는 정보들이에요")
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

/// 애플워치 미착용 상태 카드 뷰
struct ReConnectCardView: View {
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
                          width: 60,
                          height: 23,
                          buttonStyle: .filled,
                          buttonColor: .mainPurple,
                          isIndicate: false)
            {
                //TODO: Navigation 넣기
                print("HI")
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

/// 애플워치 데이터 리스트 뷰
struct WatchListView: View {
    var viewModel: WatchInfoViewModel
    var body: some View {
        VStack {
            WatchInfoRow(text: "👟 걸음수", value: viewModel.getWalk())
            WatchInfoRow(text: "❤️ 심박 평균", value: viewModel.getHeart())
            WatchInfoRow(text: "💤 수면 시간", value: viewModel.getSleep())
            WatchInfoRow(text: "🔥 소모 칼로리", value: viewModel.getKcal())
            WatchInfoRow(text: "🚶 움직인 거리", value: viewModel.getDistance())
        }
    }
}

//MARK: - Preview
struct WatchInfoView_Previews: PreviewProvider {
    static var previews: some View {
        WatchInfoView(viewModel: WatchInfoViewModel())
    }
}
