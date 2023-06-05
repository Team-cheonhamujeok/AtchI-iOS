//
//  SettingCategoriesView.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/05/23.
//

import SwiftUI

enum SettingCategory: CaseIterable {
    case privacy
    case privacyPolicy
    
    var title: String {
        switch self {
        case .privacy: return "개인정보"
        case .privacyPolicy: return "개인정보 이용약관"
        }
    }
    
    @ViewBuilder
    func getView() -> some View {
        switch self {
        case .privacy: ProfileSettingView()
        case .privacyPolicy: PrivacyPolicyView()
        }
    }
    
}

struct SettingCategoriesView: View {
    
    let categories = SettingCategory.allCases
    
    var body: some View {
        List {
            ForEach(categories, id: \.title) { category in
                NavigationLink(destination: category.getView()) {
                    Text(category.title)
                        .font(.titleSmall)
                }
                .listRowInsets(EdgeInsets())
                .padding(.vertical, 20)
                .listRowBackground(Color.clear)
            }
        }
        .scrollDisabled(true)
        .listStyle(.plain)
        .background(Color.mainBackground)
        .frame(maxWidth: .infinity)
    }
}
