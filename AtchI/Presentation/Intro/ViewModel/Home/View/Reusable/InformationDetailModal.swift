//
//  InformationDetailModal.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/03/14.
//

import SwiftUI


struct InformationDetailModal: View {
    var title: String
    var content: String
    var pictureName: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // image
            VStack{
                Image(pictureName)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(maxWidth: .infinity)
            }.frame(maxWidth: .infinity,
                    maxHeight: 200,
                    alignment: .leading)
            .background(Color.white)
            
            // title
            VStack(alignment: .leading, spacing: 10){
                Text("\(title)")
                    .font(.titleMedium)
                Text("\(content)")
                    .font(.bodyMedium)
            }.frame(maxWidth: .infinity,
                    minHeight: 40,
                    alignment: .leading)
            .padding(.horizontal, 25)
            .padding(.vertical, 15)
            .background(Color.white)
            
            // 컨텐츠 위로 밀려고 Spacer
             Spacer()
        }
        .frame(maxWidth: .infinity,
               maxHeight: .infinity,
               alignment: .leading)

    }
}
