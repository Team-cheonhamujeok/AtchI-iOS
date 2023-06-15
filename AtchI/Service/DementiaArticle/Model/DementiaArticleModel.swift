//
//  DementiaArticleModel.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/06/01.
//

import Foundation

/// 치매 정보 뷰에 표시할 정보를 담은 모델입니다.
struct DementiaArticleModel: Equatable {
    /// 문서 제목입니다.
    let title: String
    /// 문서 상단에 표시되는 이미지 이름입니다.
    let imageName: String
    /// 내용을 담은 RichText파일 이름입니다.
    let richTextfileName: String
    /// 내용(치매 정보)입니다.
    let content: String?
}
