//
//  AIResultChartView.swift
//  AtchI
//
//  Created by 강민규 on 2023/06/05.
//

import SwiftUI

import Charts

struct AIResultChartView: View {
    @Binding var notDementia: Double
    @Binding var beforeDementia: Double
    @Binding var dementia: Double
    
    var body: some View {
        Chart {
            BarMark(
                x: .value("Dementia", "치매"),
                y: .value("Value", dementia),
                width: 30
            )
            .cornerRadius(5)
            .foregroundStyle(Color.mainBlue)
            .annotation {
                Text(String(dementia))
                    .font(.caption)
                    .foregroundColor(.grayTextLight)
            }
            
            BarMark(
                x: .value("beforeDementia", "치매의심"),
                y: .value("Value", beforeDementia),
                width: 30
            )
            .cornerRadius(5)
            .foregroundStyle(Color.mainBlueLight)
            .annotation {
                Text(String(beforeDementia))
                    .font(.caption)
                    .foregroundColor(.grayTextLight)
            }
            
            BarMark(
                x: .value("notDementia", "정상"),
                y: .value("Value", notDementia),
                width: 30
            )
            .cornerRadius(5)
            .foregroundStyle(Color.grayDisabled)
            .annotation {
                Text(String(notDementia))
                    .font(.caption)
                    .foregroundColor(.grayTextLight)
            }
        }
        .chartYAxis(.hidden)
        .padding()
    }
}
