//
//  LastDateResponseModel.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/06/01.
//

import Foundation

//{
//    "success": true,  // 백엔드 로직이 정상적으로 처리되었는지 여부
//    "response": { //반환 값
//        "mid": 1,
//        "lastDate": "2024-05-26T15:00:00.000+00:00"
//    },
//    "error": "" //에러 발생시 에러 메세지
//}
//
////lastDate가 없을 때
//{
//    "success": true,
//    "response": {},
//    "error": ""
//}

struct ResponseModel<T>: Codable where T: Codable {
    let success: Bool
    let response: T
    let error: String
}

struct LastDateResponseModel: Codable {
    let mid: Int
    let lastDate: String
}
