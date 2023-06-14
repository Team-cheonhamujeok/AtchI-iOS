//
//  HealthInfoView.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/06/06.
//

import SwiftUI

struct HealthInfoView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @ObservedObject var viewModel = HealthInfoViewModel()
    
    var body: some View {
        ScrollView {
            VStack {
                // section 1
                VStack(alignment: .leading, spacing: 10) {
                    Text("최근 수집한 건강 정보")
                        .font(.titleMedium)
                    Text("AI 진단을 위해 최근(\(viewModel.state.collectionDate)) 수집한 건강 정보입니다")
                        .font(.bodyMedium)
                    
                    Divider()
                        .padding(.vertical, 10)
                    
                    HealthInfoDetailView(
                        stepCount: $viewModel.state.stepCount,
                        heartAverage: $viewModel.state.heartAverage,
                        sleepTotal: $viewModel.state.sleepTotal
                    )
                }
                .padding(.horizontal, 30)
                .padding(.top, 20)
                
                Spacer(minLength: 40)
                
                // section 2
                VStack {
                    HealthInfoDescriptionView()
                }
                .padding(.horizontal, 30)
                .padding(.vertical, 20)
                .background(Color.grayBoldLine)
            }
            .scrollIndicators(.hidden)
        }
        .background(
            VStack(spacing: .zero) {
                Color.mainBackground;
                Color.grayBoldLine
            }
        )
        .setCustomNavigationBar(
            dismiss: dismiss,
            backgroundColor: .mainBackground
        )
        .ignoresSafeArea(edges: .vertical)
        .padding(.top, 1)
        .onAppear {
            viewModel.action.viewOnAppear.send()
        }
        .background(Color.mainBackground)
    }
}

struct HealthInfoView_Previews: PreviewProvider {
    static var previews: some View {
        HealthInfoView()
    }
}
