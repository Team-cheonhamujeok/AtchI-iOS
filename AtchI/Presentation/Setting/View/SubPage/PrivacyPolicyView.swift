//
//  PrivacyPolicyView.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/05/23.
//

import SwiftUI
import MarkdownUI

struct PrivacyPolicyView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @State var policyText: String = ""
    
    var body: some View {
        ScrollView {
            VStack {
                Markdown(policyText)
                    .markdownTheme(.docC)
                    .foregroundColor(.mainText)
                    .background(Color.mainBackground)
            }
            .padding(.horizontal, 30)
            .padding(.vertical, 15)
        }
        .onAppear {
            guard let rtfPath = Bundle.main.url(forResource: "PrivacyPolicyText", withExtension: "rtf"),
                  let rtfData = try? Data(contentsOf: rtfPath),
                  let rtfText = try? NSAttributedString(data: rtfData, options: [:], documentAttributes: nil)
            else {
                print("rtf 파일을 찾을 수 없습니다.")
                return
            }
            
            self.policyText = rtfText.string
        }
        .background(Color.mainBackground)
        .setCustomNavigationBar(
            dismiss: dismiss,
            backgroundColor: .mainBackground
        )
    }
}

struct PrivacyPolicyView_Previews: PreviewProvider {
    static var previews: some View {
        PrivacyPolicyView()
    }
}
