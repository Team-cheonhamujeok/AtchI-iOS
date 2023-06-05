//
//  MMSESaveResponseModel.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/06/04.
//

import Foundation

/**
{
    "message": "Success save",
    "resultProba": [
        0.8396678127252848, //Double 정상일 확률
        0.8533068855407249, //Double 치매 의심일 확률
        0.30702528886480557 //Double 치매일 확률
    ]
}
*/
struct MMSESaveResponseModel: Codable {
    let message: String
    let resultProba: [Double]?
}
