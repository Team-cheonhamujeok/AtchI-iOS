//
//  AIDiagnosisCard.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/03/12.
//

import SwiftUI

struct AIDiagnosisCard: View {
    
    @Environment(\.presentationMode) var presentationMode

    @StateObject var viewModel: AIDiagnosisViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 7) {
            HStack(alignment: .top) {
                VStack {
                    Text("치매 진단 결과")
                        .font(.titleMedium)
                        .foregroundColor(.mainBlue)
                }
                Spacer()
                VStack(alignment: .trailing) {
                    Text("\(viewModel.startDate)-\(viewModel.endDate)")
                    Text("데이터 기준")
                }
                .font(.bodyTiny)
                .foregroundColor(.grayTextLight)
            }
            
            switch viewModel.resultLevel {
            case .dementia:
                Text("현재 치매일 가능성이 높습니다.")
                    .font(.titleSmall)
                    .foregroundColor(.mainText)
            case .beforeDementia:
                Text("현재 치매일 가능성이 있습니다.")
                    .font(.titleSmall)
                    .foregroundColor(.mainText)
            case .notDementia:
                Text("현재 치매일 가능성이 낮습니다.")
                    .font(.titleSmall)
                    .foregroundColor(.mainText)
            case .none:
                Text("치매 진단이 어렵습니다.")
                    .font(.titleSmall)
                    .foregroundColor(.mainText)
            }
            
            AIResultChartView(viewModel: viewModel)
            
            Text("*AI 진단 정보는 참고용입니다. 정확한 진단은 의사와 상담하세요.")
                .font(.bodyTiny)
                .foregroundColor(.grayTextLight)
        }
        .padding(25)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
        .background(Color.mainBlueLight)
        .cornerRadius(20)
    }
}

struct AIDiagnosisCard_Previews: PreviewProvider {
    static var previews: some View {
        AIDiagnosisCard(viewModel: AIDiagnosisViewModel())
    }
}

