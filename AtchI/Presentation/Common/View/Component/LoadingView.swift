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
    @State var angle: Double = 0
    
    var body: some View {
        VStack {
            ZStack {
                Circle()
                    .stroke(
                        Color.grayThinLine.opacity(0.5),
                        lineWidth: 5
                    )
                    .frame(width: 50,height: 50)
                Circle()
                    .trim(
                        from: 0,
                        to: 0.2
                    )
                    .stroke(
                        Color.grayDisabled,
                        style: StrokeStyle(
                            lineWidth: 5,
                            lineCap: .round
                        )
                    )
                    .frame(width: 50,height: 50)
                    .rotationEffect(.degrees(angle))
                    .animation(
                        .linear(duration: 1.5)
                        .repeatForever(autoreverses: false),
                        value: angle
                    )
                
            }
        }
        .padding(10)
        .onAppear {
            DispatchQueue.global().asyncAfter(deadline: .now(), execute: {
                progress = progress + 1
                angle += 360
            })
        }
    }
    
    var animationFromPosition: Double {
        if progress < 0.2 {
            return progress-1
        } else if progress < 0.8 {
            return progress-0.2
        } else {
            return progress
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
