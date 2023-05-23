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
            WatchListView(viewModel: viewModel)
        }
    }
    
    //MARK: - 애플워치가 등록안되었을 때
    var noWatchView: some View {
        VStack {
            ExplainWatchView(isConnected: $viewModel.isConnectedWatch)
            ReConnectCardView(viewModel: viewModel)
        }
    }
}


//MARK: - Preview
struct WatchInfoView_Previews: PreviewProvider {
    static var previews: some View {
        WatchInfoView(viewModel: WatchInfoViewModel())
    }
}
