//
//  YNetworkKitTests.swift
//  
//
//  Created by Yusuf Özgül on 28.02.2021.
//

import XCTest
@testable import YNetworkKit

struct TestResponse: Codable {
    let message: String
}

final class YNetworkKitTests: XCTestCase {
    var mockURLSession: MockURLSession!
    var mockInteractor: MockInteractor!
    var request: BaseRequestProtocol!
    
    override func setUp() {
        ApiConstant.apiDefault.set(defaultDomain: "https://yusufozgul.com")
        request = BaseRequestModel(path: "/TestResponse", method: .GET([]))
        
        let bundle = Bundle.module
        
        mockURLSession = .init(bundle: bundle)
        mockInteractor = .init()
    }
    
    func test_MockURLSession() {
        let exp = expectation(description: "Check response is successful")
        mockInteractor.send(requestData: request,
                            modelType: TestResponse.self,
                            decoder: .init(),
                            urlSession: mockURLSession) { (result) in
            exp.fulfill()
            switch result {
            case .success(let response):
                XCTAssertEqual(response.message, "Hello World...")
            case .failure(let error):
                XCTFail("Error not expected. \(error)")
            }
        }
        
        waitForExpectations(timeout: 10) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
        }
    }
    
    func test_MockURLSession_WrongJson() {
        request = BaseRequestModel(path: "/WrongTestResponse", method: .GET([]))
        let exp = expectation(description: "Check response is error")
        
        mockInteractor.send(requestData: request,
                            modelType: TestResponse.self,
                            decoder: .init(),
                            urlSession: mockURLSession) { (result) in
            exp.fulfill()
            switch result {
            case .success(let response):
                XCTFail("Success not expected. \(response)")
            case .failure(let error):
                XCTAssertEqual(error.detailedDescription, "message was not found, No value associated with key CodingKeys(stringValue: \"message\", intValue: nil) (\"message\").")
            }
        }
        
        waitForExpectations(timeout: 10) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
        }
    }
}
