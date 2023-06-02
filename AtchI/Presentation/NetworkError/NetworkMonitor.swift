//
//  NetworkCheck.swift
//  AtchI
//
//  Created by 강민규 on 2023/06/01.
//

import Foundation
import Network

/*
    네트워크 연결 참고 레퍼런스
 https://qteveryday.tistory.com/m/314
 */

final class NetworkMonitor {
    static let shared = NetworkMonitor()
    private let queue = DispatchQueue.global()
    private let monitor: NWPathMonitor
    
    public private(set) var isConnected: Bool = false
    public private(set) var connectionType: ConnectionType = .unknown
    
    enum ConnectionType {
        case wifi
        case cellular
        case ethernet
        case unknown
    }
    
    private init() {
        monitor = NWPathMonitor()
    }
    
    // Network Monitoring 시작
        public func startMonitoring() {
            monitor.start(queue: queue)
            monitor.pathUpdateHandler = { [weak self] path in

                self?.isConnected = path.status == .satisfied
                self?.getConnectionType(path)

                if self?.isConnected == true {
                    print("연결됨!")
                } else {
                    print("연결안됨!")
                }
            }
        }

        // Network Monitoring 종료
        public func stopMonitoring() {
            monitor.cancel()
        }

        // Network 연결 타입
        private func getConnectionType(_ path: NWPath) {
            if path.usesInterfaceType(.wifi) {
                connectionType = .wifi
            } else if path.usesInterfaceType(.cellular) {
                connectionType = .cellular
            } else if path.usesInterfaceType(.wiredEthernet) {
                connectionType = .ethernet
            } else {
                connectionType = .unknown
            }
        }
    
}
