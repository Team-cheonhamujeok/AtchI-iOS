//
//  AIDiagnosisCard.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/03/12.
//

import SwiftUI

struct AIDiagnosisCard: View {
    
    @Environment(\.presentationMode) var presentationMode
    @Binding var startDate: String
    @Binding var endDate: String
    @Binding var notDementia: Double
    @Binding var beforeDementia: Double
    @Binding var dementia: Double
    
    @Binding var resultLevel: AIResultLevel?
    
    @Binding var isLoading: Bool
    @Binding var haveMMSE: Bool
    @Binding var haveLifePattern: Bool
    
    var body: some View {
        VStack {
            if isLoading {
                HStack(alignment: .center) {
                    Spacer()
                    LoadingView()
                    Spacer()
                }
            } else {
                if haveLifePattern == false {
                    noMMSEView
                } else if haveMMSE == false {
                    noLifePatternView
                } else {
                    dementiaDiagnosisResultView
                }
            }
        }
        .frame(minHeight: 350)
    }
    
    /// LifePattern이 없을 때 내보내는 View
    var noLifePatternView: some View {
        VStack(alignment: .leading, spacing: 7) {
            Text("치매 진단 준비중 🥲")
                .font(.titleMedium)
                .foregroundColor(.mainBlue)
            
            Group {
                Text("AI 진단을 위한")
                Text("데이터가 부족합니다.")
            }
                .font(.bodyLarge)
                .foregroundColor(.mainText)
            
            Group {
                Text("사용자의 데이터를 바탕으로 ")
                Text("AI가 치매 진단을 해줍니다!")
                Text("정확한 진단을 위해")
                Text("애플워치를 차고 활동해주세요!")
            }
            .font(.bodyMedium)
            .foregroundColor(.mainText)
            
            Text("")
            Text("*AI 진단은 120일 이상의 데이터가 있어야 이용하실 수 있습니다.")
                .font(.bodyTiny)
                .foregroundColor(.grayTextLight)
        }
        .padding(25)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
        .background(Color.mainBlueLight)
        .cornerRadius(20)
    }

    /// mmse 진단 결과가 없을 때 내보내는 View
    var noMMSEView: some View {
        VStack(alignment: .leading, spacing: 7) {
            Text("치매 진단 준비중 🥲")
                .font(.titleMedium)
                .foregroundColor(.mainBlue)
                
            Spacer()
            
            Group {
                Text("AI 진단을 위한")
                Text("MMSE 검사가 존재하지 않습니다.")
            }
            .font(.bodyLarge)
            .foregroundColor(.mainText)
            
            VStack(alignment: .leading, spacing: 5) {
                Text("사용자의 MMSE 검사를 바탕으로")
                Text("AI가 치매 진단을 해줍니다!")
                Text("정확한 진단을 위해")
                Text("MMSE 검사를 해주세요!")
                
            }
            .font(.bodyMedium)
            .foregroundColor(.mainText)
            
            Spacer()
            
            DefaultButton(buttonSize: .small,
                          width: .infinity,
                          height: 40,
                          buttonStyle: .filled,
                          buttonColor: .mainBlue,
                          isIndicate: false) {
                //TODO: Link
                // MMSE 검사 StartView로 전달
            } content: {
                Text("MMSE 검사 바로가기")
                    .font(.bodyMedium)
            }
            Spacer()
        }
        .padding(25)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
        .background(Color.mainBlueLight)
        .cornerRadius(20)
    }
    
    /// 진단 결과가 있을 때 내보내는 View
    var dementiaDiagnosisResultView : some View {
        VStack(alignment: .leading, spacing: 7) {
            HStack(alignment: .top) {
                VStack {
                    Text("치매 진단 결과")
                        .font(.titleMedium)
                        .foregroundColor(.mainBlue)
                }
                Spacer()
                VStack(alignment: .trailing) {
                    Text("\(startDate)-\(endDate)")
                    Text("데이터 기준")
                }
                .font(.bodyTiny)
                .foregroundColor(.grayTextLight)
            }
            
            switch resultLevel {
            case .dementia:
                Text("치매일 가능성이 높습니다")
                    .font(.titleSmall)
                    .foregroundColor(.mainText)
            case .beforeDementia:
                Text("치매로 발전될 가능성이 있습니다")
                    .font(.titleSmall)
                    .foregroundColor(.mainText)
            case .notDementia:
                Text("치매일 가능성이 낮습니다")
                    .font(.titleSmall)
                    .foregroundColor(.mainText)
            case .none:
                Text("치매 진단이 어렵습니다.")
                    .font(.titleSmall)
                    .foregroundColor(.mainText)
            }
            AIResultChartView(notDementia: $notDementia,
                              beforeDementia: $beforeDementia,
                              dementia: $dementia)
            
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
