//
//  SettingCategoriesView.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/05/23.
//

import SwiftUI

import StackCoordinator

struct SettingListView: View {
    
    var coordinator: BaseCoordinator<SettingLink>
    
    let links = SettingLink.allCases
    
    var body: some View {
        List {
            ForEach(links, id: \.title) { link in
                HStack {
                    Text(link.title)
                        .font(.titleSmall)
                    
                    Spacer()
                    
                    ArrowRight()
                        .frame(width: 18*0.7, height: 24*0.7)
                        .foregroundColor(Color.grayDisabled)
                }
                .listRowInsets(EdgeInsets())
                .padding(.vertical, 20)
                .listRowBackground(Color.clear)
                .contentShape(Rectangle())
                .onTapGesture {
                    coordinator.path.append(link)
                }
            }
        }
        .scrollDisabled(true)
        .listStyle(.plain)
        .background(Color.mainBackground)
        .frame(maxWidth: .infinity)
    }
}
