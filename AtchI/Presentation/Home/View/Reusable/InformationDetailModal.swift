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
            VStack{
                Image(pictureName)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(maxWidth: .infinity)
            }.frame(maxWidth: .infinity,
                    maxHeight: 140,
                    alignment: .leading)
            .background(Color.white)
            
            VStack(alignment: .leading){
                Text("\(title)")
                    .font(.titleSmall)
                Spacer()
                Text("\(content)")
                    .font(.bodySmall)
                    .lineLimit(2)
            }.frame(maxWidth: .infinity,
                    minHeight: 40,
                    alignment: .leading)
            .padding(.horizontal, 25)
            .padding(.vertical, 15)
            .background(Color.white)
        }
        .frame(maxWidth: .infinity,
               maxHeight: .infinity,
               alignment: .leading)

    }
}
