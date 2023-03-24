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
                width: 300,
                height: 50,
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
                buttonSize: .small,
                width: 85,
                height: 35,
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
            
        }
    }
}

struct ButtonTest_Previews: PreviewProvider {
    static var previews: some View {
        ButtonTest()
    }
}
