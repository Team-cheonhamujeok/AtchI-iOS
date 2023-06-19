//
//  DementiaArticleService.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/06/01.
//

import Foundation


class DementiaArticleService {

    private let bundleHeler: BundleHelperProtocol

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
