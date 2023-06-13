//
//  URL.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/05/16.
//

import Foundation


extension URL {
    
    /// 앱 딥링크 스키마와 일치하는 문자열입니다.
    var isDeeplink: Bool {
        return scheme == "atchi" // matches my-url-scheme://<rest-of-the-url>
    }
    
    /// URL의 host(스키마 이후 처음 값)를 반환합니다.
    var deepLinkHost: String? {
        guard isDeeplink else { return nil }
        
        return host
    }
    
    /// URL의 host로 들어온 string을 TabBarType에 매핑하여 반환합니다.
    var deepLinkHostMapTabBar: TabBarType? {
        guard isDeeplink else { return nil }
        
        switch host {
        case "home": return .home
        case "diagnosis": return .diagnosis
        case "prevent": return .prevent
        case "setting": return .setting
        default: return nil
        }
    }
    
    /// URL의 path(host 이후, 쿼리 스트링전)를 순서대로 String 배열에 담아 반환합니다.
    var deepLinkPath: [String] {
        guard let components = NSURLComponents(url: self, resolvingAgainstBaseURL: true),
              let path = components.path else {
            return []
        }
        
        return path.components(separatedBy: "/").filter { !$0.isEmpty }
    }
    
    /// URL의 query string 값을 딕셔너리 형태로 반환합니다.
    var deepLinkQueryItems: [String : String] {
        var queryItems: [String : String] = [:]
        var components: NSURLComponents? = nil
        let linkUrl = URL(string: self.absoluteString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) ?? "")
        if let linkUrl = linkUrl {
            components = NSURLComponents(url: linkUrl, resolvingAgainstBaseURL: true)
        }
        for item in components?.queryItems ?? [] {
            queryItems[item.name] = item.value?.removingPercentEncoding
        }
        return queryItems
    }

}
