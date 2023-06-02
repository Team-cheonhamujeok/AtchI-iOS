//
//  NetworkErrorView.swift
//  AtchI
//
//  Created by 강민규 on 2023/06/01.
//

import SwiftUI

struct NetworkErrorView: View {
    var body: some View {
        VStack(spacing: 20) {
            Image("no-internet")
            Text("연결된 네트워크가 없어요")
                .font(.titleMedium)
            Text("네트워크 상태를 확인해주세요")
                .font(.bodyMedium)
                .foregroundColor(.grayTextLight)
        }
    }
}

struct NetworkErrorView_Previews: PreviewProvider {
    static var previews: some View {
        NetworkErrorView()
    }
}
