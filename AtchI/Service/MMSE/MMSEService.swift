//
//  MMSEService.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/05/24.
//

import CoreLocation
import Combine
import Foundation

import CombineMoya
import Moya

/// MMSE 내부 계산 및 문항 파싱을 담당하는 Service입니다.
class MMSEService {
    
    let provider: MoyaProvider<MMSEAPI>
    private let bundelHelper = BundelHelper()
    private let locationHelper = LocationHelper()
    
    init(provider: MoyaProvider<MMSEAPI>) {
        self.provider = provider
    }
    
    var cancellables = Set<AnyCancellable>()
    
    func reqeustMMSEResults(mid: Int) -> AnyPublisher<Moya.Response, MMSEError> {
        return provider.requestPublisher(.getList(mid: mid))
            .tryMap { response -> Response in
                return response
            }
            .mapError { error in
                return MMSEError.getFail
            }
            .eraseToAnyPublisher()
    }
    
    
    func requestSaveMMESE(_ MMSESaveRequestModel: MMSESaveRequestModel) -> AnyPublisher<Void, MMSEError> {
        return provider.requestPublisher(.saveMMES(model: MMSESaveRequestModel))
            .tryMap{ _ in }
            .mapError { _ in return MMSEError.saveFailed }
            .eraseToAnyPublisher()
    }
    
    /// MMSE plist 파일에 있는 식별자와 질문을 파싱해 MMSEQuestionModel로 변환합니다.
    func getMMSEQuestions() -> [MMSEQuestionModel] {
        // plist 파일 가져오기 & 파싱
        let plist = bundelHelper.parsePlist("MMSEQuestions")
        
        return plist.enumerated().compactMap { idx, item -> MMSEQuestionModel? in
            guard let identifier = item["identifier"],
                  let question = item["question"],
                  let answer = item["answer"]
            else { return nil }
            
            return MMSEQuestionModel(identifier: identifier,
                                     order: "\(idx+1)번째 문항",
                                     question: question,
                                     answer: answer)
        }
    }
    
    func checkIsCorrect(questionModel: MMSEQuestionModel,
                        userAnswer: String,
                        completion: @escaping (Bool) -> Void) {
        switch questionModel.viewType {
        case .reply(let replayType):
            switch replayType {
            case .country:
                // 나라명 일치하는지 확인
                locationHelper
                    .getLocationName(locationType: .country) { country in
                        completion(country == userAnswer || "한국" == userAnswer)
                    }
                return
                
            case .city:
                // 시/도 + 동/읍/면 중에 일치하는 문자열이 있는지 확인
                locationHelper
                    .getLocationName(locationType: .address) { address in
                        if let address = address {
                            let addressCandidates = address.components(separatedBy: " ")
                            completion(addressCandidates.contains(userAnswer))
                        } else { completion(false) }
                    }
                return
                
            case .year:
                let currentYear = Calendar.current.component(.year, from: Date())
                let currentYearStr = String(currentYear)
                let lastTwoChars = String(currentYearStr.suffix(2))
                completion(currentYearStr == userAnswer || lastTwoChars == userAnswer)
                return
                
            case .month:
                let currentYear = Calendar.current.component(.month, from: Date())
                completion(String(currentYear) == userAnswer)
                return
                
            case .day:
                let currentYear = Calendar.current.component(.day, from: Date())
                completion(String(currentYear) == userAnswer)
                return
                
            case .week:
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "EEEE"
                dateFormatter.locale = Locale(identifier: "ko_KR")
                let currentDayOfWeek = dateFormatter.string(from: Date())
                completion(currentDayOfWeek.prefix(1) == userAnswer)
                return
                
            default:
                completion(questionModel.answer == userAnswer)
                return
            }
        case .show(_):
            completion(false)
            return
        default:
            completion(questionModel.answer == userAnswer)
            return
        }
    }
}
