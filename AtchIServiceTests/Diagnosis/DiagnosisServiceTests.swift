//
//  DiagnosisServiceTests.swift
//  AtchIServiceTests
//
//  Created by 강민규 on 2023/05/01.
//
@testable import AtchI
import XCTest

import Moya

final class DiagnosisServiceTests: XCTestCase {
    
    var sut: DiagnosisServiceType!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.sut = DiagnosisService(provider: MoyaProvider<DiagnosisAPI>() )
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        self.sut = nil
    }
    
    func test_nowDate() throws {
        let now = Date() //"Mar 21, 2018 at 1:37 PM"
        let dateFormatter = DateFormatter()
        // 목표 형식 2020-01-02T00:00:00.000+00:00
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
        print("#", dateFormatter.string(from: now))
    }
    
    func test_Date() throws {
        let time = "2020-01-02T00:00:00.000+00:00"
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        
        let convertDate = dateFormatter.date(from: time)!
            
        dateFormatter.dateFormat = "yy년MM월dd일"
        
        print(dateFormatter.string(from: convertDate))
    }

    func test_자가진단_유저_결과들고오기() throws {
        let expectation = XCTestExpectation(description: "fetches data and updates properties.")
        let request = sut.getDiagnosisList(mid: 1)
        
        let cancellable = request
                            .handleEvents(receiveSubscription: { _ in
                              print("Network request will start")
                            }, receiveOutput: { _ in
                              print("Network request data received")
                            }, receiveCancel: {
                              print("Network request cancelled")
                            })
                            .sink(receiveCompletion: { com in
                                print("com", com)
                            }, receiveValue: { response in
                                print("response", response)
                                let decoder = JSONDecoder()
                                if let json = try? decoder.decode([DiagnosisGetModel].self, from: response.data) {
                                  print(json) // hyeon
                                }
                                expectation.fulfill()
                            })
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    func test_자가진단_결과_post하기() throws {
        let expectation = XCTestExpectation(description: "post data and updates properties.")
        let request = sut.postDiagnosis(postDTO: DiagnosisTestData.postSampleData)
        
        let cancellable = request
                            .handleEvents(receiveSubscription: { _ in
                              print("Network request will start")
                            }, receiveOutput: { _ in
                              print("Network request data received")
                            }, receiveCancel: {
                              print("Network request cancelled")
                            })
                            .sink(receiveCompletion: { com in
                                print("com", com)
                            }, receiveValue: { response in
                                print("response", response)
                                
                                expectation.fulfill()
                            })
        
        wait(for: [expectation], timeout: 10.0)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
