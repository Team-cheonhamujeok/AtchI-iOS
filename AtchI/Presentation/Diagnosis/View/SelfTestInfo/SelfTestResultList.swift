//
//  SelfTestResultList.swift
//  AtchI
//
//  Created by 강민규 on 2023/03/31.
//

import SwiftUI

struct SelfTestResultList: View {
    
    @Binding var path: [DiagnosisViewStack]
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct SelfTestResultList_Previews: PreviewProvider {
    static var previews: some View {
        SelfTestResultList(path: .constant([]))
    }
}
