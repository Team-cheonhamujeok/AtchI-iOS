//
//  DiagnosisView.swift
//  AtchI
//
//  Created by 강민규 on 2023/03/21.
//

import SwiftUI

import Moya

struct DiagnosisView: View {
    
    let selfTestViewModel = SelfTestViewModel(service: DiagnosisService(provider: MoyaProvider<DiagnosisAPI>()))
    let selfTestInfoViewModel = SelfTestInfoViewModel(service: DiagnosisService(provider: MoyaProvider<DiagnosisAPI>()))
    let mmseInfoViewModel = MMSEInfoViewModel(service: MMSEInfoService(provider: MoyaProvider<MMSEInfoAPI>()))
    
    @State private var path: [DiagnosisViewStack] = []
    
    var body: some View {
        NavigationStack(path: $path) {
            ScrollView {
                VStack(alignment: .leading) {
                    Text("진단")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.bottom, 18)
                        .padding(.horizontal, 30)
                    
                    SelfTestInfoView(
                        viewModel: selfTestInfoViewModel,
                        path: $path)
                    
                    
                    Rectangle()
                        .frame(height: 10)
                        .foregroundColor(.grayBoldLine)
                        .padding(.bottom, 10)
                    
                    MMSEInfoView(viewModel: mmseInfoViewModel,
                                 path: $path)
                    
                    Spacer()
                }
            }
            .navigationDestination(for: DiagnosisViewStack.self) { child in
                switch child {
                case .selfTest:
                    SelfTestView(path: $path,
                                 selfTestViewModel: selfTestViewModel)
                case .selfTestStart:
                    SelfTestStartView(path: $path,
                                      selfTestViewModel: selfTestViewModel)
                case .selfTestResult:
                    SelfTestResultView(path: $path,
                                       selfTestViewModel: selfTestViewModel,
                                       selfTestInfoViewModel: selfTestInfoViewModel)
                case .selfTestResultList:
                    SelfTestResultList(path: $path,
                                       selfTestInfoViewModel: selfTestInfoViewModel)
                case .mmseResultList:
                    MMSEResultList(path: $path,
                                   mmseInfoViewModel: mmseInfoViewModel)
                default:
                    Text("잘못된 접근")
                }
            }
            .scrollDisabled(true)
        }
        .onAppear {
            //MARK: 서버 데이터 들고오기
            selfTestInfoViewModel.requestData()
            mmseInfoViewModel.requestData()
        }
    }
}

struct DiagnosisView_Previews: PreviewProvider {
    static var previews: some View {
        DiagnosisView()
    }
}
