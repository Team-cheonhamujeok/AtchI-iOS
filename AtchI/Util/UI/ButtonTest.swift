//
//  ButtonTest.swift
//  AtchI
//
//  Created by 강민규 on 2023/03/19.
//

import SwiftUI

struct ButtonTest: View {
    var body: some View {
        VStack{
            DefaultButton(
                buttonSize: .large,
                buttonStyle: .filled,
                buttonColor: .mainPurple,
                isIndicate: false,
                action: {
                    print("HI")
                },
                content: {
                    Text("Button")
                }
            )
            DefaultButton(
                buttonSize: .large,
                buttonStyle: .unfilled,
                buttonColor: .mainPurple,
                isIndicate: false,
                action: {
                    print("HI")
                },
                content: {
                    Text("Button")
                }
            )
        }
    }
}

struct ButtonTest_Previews: PreviewProvider {
    static var previews: some View {
        ButtonTest()
    }
}
