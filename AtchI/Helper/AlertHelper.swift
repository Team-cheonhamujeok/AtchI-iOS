//
//  AlertHelper.swift
//  HumanscapeShoppingMall
//
//  Created by DOYEON LEE on 2023/06/04.
//

import Foundation
import UIKit

final class AlertHelper {
    static func showAlert(title: String = "알림", message: String?, action: UIAlertAction?) {
        
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
//        alert.addAction(
//            .init(title: "확인",
//                  style: .cancel))
        if action != nil {
            alert.addAction(action!)
            alert.addAction(
                .init(title: "취소",
                      style: .cancel))
        } else {
            alert.addAction(
                .init(title: "확인",
                      style: .cancel))
        }
        
        rootController().present(alert, animated: true)
    }
    
//    static func showAlertWithChoice(title: String = "알림", message: String?, action: UIAlertAction) {
//        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
//
//        alert.addAction(.init(title: "취소", style: .cancel))
//
//    }
    
    private static func rootController() -> UIViewController {
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return .init()
        }
        
        guard let root = screen.windows.first?.rootViewController else {
            return .init()
        }
        
        return root
    }
}
