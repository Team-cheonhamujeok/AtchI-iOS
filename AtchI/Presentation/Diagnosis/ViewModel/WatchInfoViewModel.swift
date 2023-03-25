//
//  WatchInfoViewModel.swift
//  AtchI
//
//  Created by 강민규 on 2023/03/23.
//

import Foundation

class WatchInfoViewModel: ObservableObject {
    //MARK: - Data
    /// 사용자 워치 데이터 (현재 더미데이터)
    @Published var watchInfo: WatchInfo = WatchInfo(walk: 1003,
                                                    heart: 89,
                                                    sleep: Date(),
                                                    kcal: 212,
                                                    distance: 3.4)
    /// 현재 워치가 연결되었는가?
    @Published var isConnectedWatch: Bool = false
    
    //MARK: - 워치 데이터 가져오기
    func getWalk() -> String {
        return "\(watchInfo.walk)걸음"
    }
    
    func getHeart() -> String {
        return "\(watchInfo.heart)bpm"
    }
    
    func getSleep() -> String {
        let date = watchInfo.sleep
        let dateFormmater = DateFormatter()
        dateFormmater.dateFormat = "HH시간 MM분"
        
        return dateFormmater.string(from: date)
    }
    
    func getKcal() -> String {
        return "\(watchInfo.kcal)kcal"
    }
    
    func getDistance() -> String {
        return "\(watchInfo.distance)km"
    }
}
