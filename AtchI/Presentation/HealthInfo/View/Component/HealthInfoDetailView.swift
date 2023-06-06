//
//  HealthInfoDetailView.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/05/21.
//

import Foundation
import SwiftUI

struct HealthInfoDetailView: View {
    
    @Binding var stepCount: String
    @Binding var heartAverage: String
    @Binding var sleepTotal: String
    
    @State private var isWatchActiityModalOpen: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text("현재 활동 정보")
                    .font(.titleSmall)
                Spacer()
                Image("question_circle")
                    .foregroundColor(.grayDisabled)
                    .onTapGesture {
                        isWatchActiityModalOpen = true
                    }
            }
            Text("AI 진단에 쓰이고 있는 활동 정보들입니다!")
                .font(.bodyMedium)
            Spacer(minLength: 5)
            
            VStack(spacing: 15) {
                HStack {
                    Text("👟 걸음수")
                        .font(.bodyMedium)
                    Spacer()
                    if stepCount.count == 0 {
                        LottieView(lottieFile: "dots-loading",
                                   loopMode: .loop)
                        .frame(width: 70,
                               height: 20)
                    } else {
                        Text("\(stepCount)")
                            .font(.bodyMedium)
                    }
                }
                HStack {
                    Text("❤️ 심박평균")
                        .font(.bodyMedium)
                    Spacer()
                    if heartAverage.count == 0 {
                        LottieView(lottieFile: "dots-loading",
                                   loopMode: .loop)
                        .frame(width: 70,
                               height: 20)
                    } else {
                        Text("\(heartAverage)")
                            .font(.bodyMedium)
                    }
                }
                HStack {
                    Text("💤 수면시간")
                        .font(.bodyMedium)
                    Spacer()
                    if sleepTotal.count == 0 {
                        LottieView(lottieFile: "dots-loading",
                                   loopMode: .loop)
                        .frame(width: 70,
                               height: 20)
                    } else {
                        Text("\(sleepTotal)")
                            .font(.bodyMedium)
                    }
                }
            }
        }
        .sheet(isPresented: $isWatchActiityModalOpen) {
            WatchActivityDescriptionModal()
                .presentationDetents([.height(440)])
        }
    }
}


struct WatchActivityView_Previews: PreviewProvider {
    static var previews: some View {
        HealthInfoDetailView(stepCount: .constant(""), heartAverage: .constant(""), sleepTotal: .constant(""))
    }
}
