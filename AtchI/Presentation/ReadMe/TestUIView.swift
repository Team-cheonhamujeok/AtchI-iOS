//
//  TestUIView.swift
//  AtchI
//
//  Created by 강민규 on 2023/05/22.
//

import SwiftUI

struct TestUIView: View {
    var body: some View {
        NavigationView {
            HStack{
                NavigationLink(destination: ReadMeView(urlToLoad: "https://www.naver.com")) {
                    Text("네이버")
                        .edgesIgnoringSafeArea(.all)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.black)
                        .cornerRadius(20, antialiased: true)
                }
            }
        }
    }
}
