//
//  DementiaArticleService.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/06/01.
//

import Foundation

/// 치매 정보 뷰에 표시할 정보를 담은 모델입니다.
struct DementiaArticleModel {
    /// 문서 제목입니다.
    let title: String
    /// 문서 상단에 표시되는 이미지 이름입니다.
    let imageName: String
    /// 내용을 담은 RichText파일 이름입니다.
    let richTextfileName: String
    /// 내용(치매 정보)입니다.
    let content: String?
}

class DementiaArticleService {
    
    let bundleHeler: BundleHelperProtocol
    
    init(bundleHeler: BundleHelperProtocol = BundleHelper.shared) {
        self.bundleHeler = bundleHeler
    }
    
    /// DementiaArticelsMeta.plist 파일에 있는 내용 파싱해 DementiaArticleModel로 변환합니다.
    func getDementiaArticles() -> [DementiaArticleModel] {
        // Articel Meta 정보 가져오기 (파싱)
        let plist = bundleHeler.parsePlistFile("DementiaArticelsMeta")
        
        return plist.enumerated().compactMap { idx, item -> DementiaArticleModel? in
            guard let title = item["title"],
                  let imageName = item["imageName"],
                  let richTextfileName = item["richTextfileName"]
            else { return nil }
            
            let content = bundleHeler.parseRichTextFile(richTextfileName)
            
            return DementiaArticleModel(title: title,
                                        imageName: imageName,
                                        richTextfileName: richTextfileName,
                                        content: content)
        }
    }
    
    
}
