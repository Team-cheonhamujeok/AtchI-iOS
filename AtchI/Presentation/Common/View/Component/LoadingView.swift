//
//  LoadingView.swift
//  AtchI
//
//  Created by 강민규 on 2023/06/02.
//

import SwiftUI

struct LoadingView: View {
    // 0...1 = 0%...100%
    @State var progress: Double = 0
    
    var body: some View {
        VStack {
            ZStack {
                Circle()
                    .stroke(
                        Color.mainPurpleLight.opacity(0.5),
                        lineWidth: 10
                    )
                    .frame(width: 50,height: 50)
                Circle()
                    .trim(from: 0, to: progress)
                    .stroke(
                        Color.grayDisabled,
                        style: StrokeStyle(
                            lineWidth: 10,
                            lineCap: .round
                        )
                    )
                    .frame(width: 50,height: 50)
                    .rotationEffect(.degrees(-90))
                    .animation(.easeOut(duration: 1), value: progress)
                
            }
        }
        .padding(10)
        .onAppear {
            DispatchQueue.global().asyncAfter(deadline: .now(), execute: {
                progress = progress + 1
            })
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
