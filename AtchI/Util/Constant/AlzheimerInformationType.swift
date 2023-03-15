//
//  AlzheimerInformationType.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/03/14.
//

import Foundation

/// 치매 정보 네임스페이스 입니다.
///
/// AlzheimerInformation 구조체를 static let으로 갖습니다.
/// - Author: doyeon
/// - SeeAlso: AlzheimerInformation
enum AlzheimerInformationType: CaseIterable {
    static let whatIsAlzheimer = AlzheimerInformation(
        pictureName: "picture1",
        title: "치매란 무엇인가요",
        content: "치매는 뇌 기능이 점차적으로 저하되면서 인지 기능(인지능력)이 저하되는 질환입니다. 주로 노인층에서 발생하지만, 어린이나 성인도 드물게 발생할 수 있습니다. 치매의 가장 일반적인 원인은 알츠하이머병입니다. \n \n알츠하이머병은 뇌 세포의 손상으로 인해 뇌세포간의 연결이 저하되면서 뇌기능이 손상되는 질환입니다. 다른 형태의 치매로는 혈관성 치매, 전신성 치매 등이 있습니다. \n\n치매는 기억력, 사고력, 판단력, 언어 능력 등을 포함한 다양한 인지 기능을 감소시키며, 일상 생활에서 간단한 일상생활도 어려워질 수 있습니다. 치매는 아직 완전히 치료할 수 없지만, 적극적인 치료와 적절한 관리, 라이프스타일 변화 등으로 증상을 완화시키고 삶의 질을 개선할 수 있습니다.")
    
    static let howMuchTreatment = AlzheimerInformation(
        pictureName: "picture1",
        title: "치매 치료 비용은 얼마인가요?",
        content: "매 치료 비용은 국가 및 지역에 따라 다르며, 치매 치료 방법에 따라서도 크게 차이가 있습니다. 일반적으로 치매 치료에는 약물 치료, 인지 행동 요법, 심리치료 등이 포함됩니다. 또한, 치매를 가진 환자를 돌보는 비용도 매우 크기 때문에, 이 역시 치매 치료 비용의 일부분을 차지합니다. \n\n따라서, 정확한 치매 치료 비용을 말씀드리기는 어렵습니다. 치매 예방 및 조기 진단을 통해 치매 발생을 예방하거나 조기에 대처할 수 있도록 노력하는 것이 중요합니다.")
}
