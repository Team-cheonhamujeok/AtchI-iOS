//
//  AIResultChartView.swift
//  AtchI
//
//  Created by 강민규 on 2023/06/05.
//

import SwiftUI

import Charts

struct AIResultChartView: View {
    
    @StateObject var viewModel: AIDiagnosisViewModel
    
    var body: some View {
        Chart {
            ForEach((0...3), id: \.self) { i in
                BarMark(
                  x: .value("Mount", "치매"),
                  y: .value("Value", i)
                )
                .annotation {
                    Text(String(i))
                        .font(.caption)
                        .foregroundColor(.grayTextLight)
                }
            }
        }
        .chartYAxis(.hidden)
        .padding()
    }
}

struct AIResultChartView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
