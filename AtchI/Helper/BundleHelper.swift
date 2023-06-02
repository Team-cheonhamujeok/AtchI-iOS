//
//  BundelHelper.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/05/23.
//

import Foundation

protocol BundleHelperProtocol {
    /// .plist(Property List 파일) 내용을 파싱합니다.
    /// - Parameter plistName: plist 파일 이름을 전달합니다.
    /// - Returns: String형 key:value를 가진 딕셔너리 배열을 반환합니다.
    /// - Warning: plist파일 형태가 Array(Dictionary(String:String))인지 확인하고 사용해주세요.
    func parsePlistFile(_ plistName: String) -> [[String: String]]
    
    /// .rtf(Rich Text 파일) 내용을 파싱합니다.
    /// - Parameter plistName: rtf 파일 이름을 전달합니다.
    /// - Returns: rtf 파일의 내용을 String으로 반환합니다.
    func parseRichTextFile(_ richTextFileName: String) -> String
}

class BundleHelper: BundleHelperProtocol {
    
    static let shared = BundleHelper()
    
    private init() { }
    
    func parsePlistFile(_ plistFileName: String) -> [[String: String]] {
        guard let plistPath = Bundle.main.url(forResource: plistFileName,
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
    
    func parseRichTextFile(_ richTextFileName: String) -> String {
        
        guard let rtfPath = Bundle.main.url(forResource: richTextFileName, withExtension: "rtf"),
              let rtfData = try? Data(contentsOf: rtfPath),
              let rtfText = try? NSAttributedString(data: rtfData, options: [:], documentAttributes: nil)
        else {
            fatalError("TestRichText 파일을 찾을 수 없습니다.")
        }

        return rtfText.string
        
    }
}
