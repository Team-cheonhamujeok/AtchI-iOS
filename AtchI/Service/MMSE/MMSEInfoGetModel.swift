//
//  MMSEInfoModel.swift
//  AtchI
//
//  Created by 강민규 on 2023/05/29.
//

import Foundation

struct MMSEInfoGetModel: Codable {
    var mmseid: Int
    var date: String
    var result: Int
}


/*
 {
         "mmseid": 1, //INT mmse PK Id
         "date": "2024-04-27T15:00:00.000+00:00", // Date
         "result": 10 //Int 총 맞은 개수 (2로 표시된 답)
     }
 */
