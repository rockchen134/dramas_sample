//
//  dramas_sampleTests.swift
//  dramas_sampleTests
//
//  Created by Rock Chen on 2020/9/10.
//  Copyright © 2020 Rock Chen. All rights reserved.
//

import XCTest
import Moya
@testable import dramas_sample

class dramas_sampleTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testDecimal() {
        let num: Double = 4.123
        let numString = num.decimal()
        XCTAssertEqual(numString, "4.1")
    }
    
    func testDate() {        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        dateFormatter.calendar = Calendar(identifier: .iso8601)
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        if let date = dateFormatter.date(from: "2017-11-23T02:04:39.000Z") {
            XCTAssertEqual(date.toString("yyyy/MM/dd"), "2017/11/23")
        }
    }
    
    func testObserable() {
        let promise = expectation(description: "Completion handler testObserable")
        let status = Observable<Bool>(true)
        status.observer { (value) in
            XCTAssertTrue(value)
            promise.fulfill()
        }
        wait(for: [promise], timeout: 5)
    }
    
    func testProviderFactory() {
        let provider: MoyaProvider<InterviewService> = ProviderFactory.create()
        XCTAssertNotNil(provider)
    }
}
