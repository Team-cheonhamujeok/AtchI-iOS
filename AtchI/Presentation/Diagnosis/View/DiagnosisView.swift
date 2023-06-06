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
    
    let selfTestViewModel: SelfTestViewModel
    let selfTestInfoViewModel: SelfTestInfoViewModel
    let mmseInfoViewModel = MMSEInfoViewModel(service: MMSEService(provider: MoyaProvider<MMSEAPI>()))
    
//    @State private var path: [DiagnosisViewStack] = []
    var coordinator: BaseCoordinator<DiagnosisLink>
    
    init(coordinator: BaseCoordinator<DiagnosisLink>) {
        self.coordinator = coordinator
        self.selfTestViewModel = SelfTestViewModel(
            service: DiagnosisService(
                provider: MoyaProvider<DiagnosisAPI>()
            ),
            coordinator: coordinator)
        self.selfTestInfoViewModel = SelfTestInfoViewModel(
            service: DiagnosisService(
                provider: MoyaProvider<DiagnosisAPI>()
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
                    viewModel: selfTestInfoViewModel,
                    selfTestViewModel: selfTestViewModel,
                    coordinator: coordinator
                )
                
                
                Rectangle()
                    .frame(height: 10)
                    .foregroundColor(.grayBoldLine)
                    .padding(.bottom, 10)
                
                MMSEInfoView(viewModel: mmseInfoViewModel)
                
                Spacer()
            }
            .padding(.bottom, 40)
        }
//        .navigationDestination(for: DiagnosisViewStack.self) { child in
//            switch child {
//            case .selfTest:
//                SelfTestView(selfTestViewModel: selfTestViewModel)
//            case .selfTestStart:
//                SelfTestStartView(path: $path,
//                                  selfTestViewModel: selfTestViewModel)
//            case .selfTestResult:
//                SelfTestResultView(path: $path,
//                                   selfTestViewModel: selfTestViewModel,
//                                   selfTestInfoViewModel: selfTestInfoViewModel)
//            case .selfTestResultList:
//                SelfTestResultList(path: $path,
//                                   selfTestInfoViewModel: selfTestInfoViewModel)
//            case .mmseResultList:
//                MMSEResultList(path: $path,
//                               mmseInfoViewModel: mmseInfoViewModel)
//            default:
//                Text("잘못된 접근")
//            }
//        }
        .padding(.top, 1)
        
        .onAppear {
            print("DiagnosisView onAppear")
            //MARK: 서버 데이터 들고오기
            selfTestInfoViewModel.requestData()
            mmseInfoViewModel.requestData()
        }
    }
}

struct DiagnosisView_Previews: PreviewProvider {
    static var previews: some View {
        DiagnosisView(
            coordinator: BaseCoordinator<DiagnosisLink>(
                path: .constant(NavigationPath())
            )
        )
    }
}
