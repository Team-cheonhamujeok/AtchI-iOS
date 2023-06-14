//
//  String.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/05/24.
//

import Foundation

extension String {
    func containsConsecutiveSubstring(_ substring: String) -> Bool {
        let substringLength = substring.count
        let stringLength = count

        if substringLength > stringLength {
            return false
        }

        for i in 0...(stringLength - substringLength) {
            let startIndex = index(self.startIndex, offsetBy: i)
            let endIndex = index(self.startIndex, offsetBy: i + substringLength)
            let range = startIndex..<endIndex

            if self[range] == substring {
                return true
            }
        }

        return false
    }
}
