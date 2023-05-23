//
//  BundelHelper.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/05/23.
//

import Foundation

class BundelHelper {
    
    func parsePlist(_ plistName: String) -> [[String: String]] {
        guard let plistPath = Bundle.main.url(forResource: plistName,
                                              withExtension: "plist"),
              let plistData = try? Data(contentsOf: plistPath),
              let plist = try? PropertyListSerialization
                                .propertyList(from: plistData,
                                              options: .mutableContainersAndLeaves,
                                              format: nil) as? [[String: String]]
        else {
            fatalError("plist 파일을 찾을 수 없습니다.")
        }
        
        return plist
    }
}
