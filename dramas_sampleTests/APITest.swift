//
//  APITest.swift
//  dramas_sampleTests
//
//  Created by Rock Chen on 2020/9/14.
//  Copyright © 2020 Rock Chen. All rights reserved.
//

import XCTest
@testable import dramas_sample

class APITest: XCTestCase {
    
    override class func setUp() {
        
    }
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testDramasAPI() throws {
        let promise = expectation(description: "Completion handler testDramasAPI")
        
        interviewProvider.request(.dramas) { (result) in
            switch result {
            case let .success(response):
                let decoder = JSONDecoder()
                
                decoder.dateDecodingStrategy = .formatted(DateFormatter.iso8601Full)
                
                let model = try? response.filterSuccessfulStatusCodes().map(DramasResponse.self, using: decoder)
                
                if let data = model?.data {
                    XCTAssert(data.count == 6)
                } else {
                    XCTAssertNotNil(model, "Response 解析失敗")
                }
            case let .failure(error):
                XCTAssertNil(error, error.localizedDescription)
            }
            promise.fulfill()
        }
        wait(for: [promise], timeout: 5)
    }
}
