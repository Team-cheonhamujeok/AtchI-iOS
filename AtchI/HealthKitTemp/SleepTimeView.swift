//
//  SleepTimeView.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/03/28.
//


import SwiftUI

struct SleepTimeView: View {
    let service = HealthKitService()
    var body: some View {
        VStack{
            Button("Get sleep data") {
                service.getSleepData()
            }
        }
    }
}

struct SleepTimeView_Previews: PreviewProvider {
    static var previews: some View {
        SleepTimeView()
    }
}

