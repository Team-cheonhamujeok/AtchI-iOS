//
//  WatchInfoView.swift
//  AtchI
//
//  Created by 강민규 on 2023/03/21.
//

import SwiftUI

struct WatchInfoView: View {
    @State var isConnectedWatch: Bool = false
    
    //MARK: - Body
    var body: some View {
        if isConnectedWatch {
            haveWatchView
        } else {
            noWatchView
        }
    }
    
    //MARK: - 애플워치가 등록되었을 때
    var haveWatchView: some View {
        Text("Have")
    }
    
    //MARK: - 애플워치가 등록안되었을 때
    var noWatchView: some View {
        Text("No")
    }
    
}

struct WatchInfoView_Previews: PreviewProvider {
    static var previews: some View {
        WatchInfoView()
    }
}
