//
//  KeyboardHelper.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/05/25.
//

import Foundation

import UIKit
import Foundation

class KeyboardHelper: ObservableObject {
    @Published var keyboardHeight: CGFloat = 0
    @Published var isKeyboardVisible: Bool = false
    
    init() {
        
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { notification in
            self.isKeyboardVisible = true
        }

        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { notification in
            self.isKeyboardVisible = false
        }
        
        self.listenForKeyboardNotifications()
    }
    
    private func listenForKeyboardNotifications() {
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardDidShowNotification,
                                               object: nil,
                                               queue: .main) { (notification) in
            guard let userInfo = notification.userInfo,
                  let keyboardRect = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
            
            self.keyboardHeight = keyboardRect.height
        }
        
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardDidHideNotification,
                                               object: nil,
                                               queue: .main) { (notification) in
            self.keyboardHeight = 0
        }
    }
}
