//
//  DiagnosisView.swift
//  AtchI
//
//  Created by 강민규 on 2023/03/21.
//

import SwiftUI

import Moya
import StackCoordinator

struct DiagnosisView: View {
    
    var selfTestViewModel: SelfTestViewModel
    var selfTestInfoViewModel: SelfTestInfoViewModel
    let mmseInfoViewModel: MMSEInfoViewModel
    
    var coordinator: BaseCoordinator<DiagnosisLink>
    
    init(coordinator: BaseCoordinator<DiagnosisLink>) {
        self.coordinator = coordinator
        self.selfTestViewModel = SelfTestViewModel(coordinator: BaseCoordinator<SelfTestLink>()) // FIXME: 임시
        self.selfTestInfoViewModel = SelfTestInfoViewModel(
            service: DiagnosisService(
                provider: MoyaProvider<DiagnosisAPI>()
            ),
            coordinator: coordinator)
        self.mmseInfoViewModel = MMSEInfoViewModel(
            service: MMSEService(
                provider: MoyaProvider<MMSEAPI>()
            ),
            coordinator: coordinator)
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text("진단")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.bottom, 18)
                    .padding(.horizontal, 30)
                
                SelfTestInfoView(
                    selfTestViewModel: selfTestViewModel, viewModel: selfTestInfoViewModel,
                    coordinator: coordinator
                )
                .frame(minHeight: 350)
                
                Rectangle()
                    .frame(height: 12)
                    .foregroundColor(.grayBoldLine)
                    .padding(.bottom, 30)
                
                MMSEInfoView(
                    viewModel: mmseInfoViewModel,
                    coordinator: coordinator
                )
                
                Spacer()
            }
            .padding(.bottom, 40)
        }
        .padding(.top, 1)
        
        .onAppear {
            print("DiagnosisView onAppear")
            //MARK: 서버 데이터 들고오기
            selfTestInfoViewModel.requestData()
            mmseInfoViewModel.requestData()
        }
        .background(Color.mainBackground)
    }
}

struct DiagnosisView_Previews: PreviewProvider {
    static var previews: some View {
        DiagnosisView(coordinator: BaseCoordinator<DiagnosisLink>())
    }
}
