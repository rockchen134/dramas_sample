//
//  DramasDetailViewModelTest.swift
//  dramas_sampleTests
//
//  Created by Rock Chen on 2020/9/15.
//  Copyright © 2020 Rock Chen. All rights reserved.
//

import XCTest
@testable import dramas_sample

class DramasDetailViewModelTest: XCTestCase {

    var sut: DramasDetailViewModel!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        let dramasModel = DramasModel(thumb: URL(string: "https://i.pinimg.com/originals/61/d4/be/61d4be8bfc29ab2b6d5cab02f72e8e3b.jpg")!,
                                  name: "致我們單純的小美好",
                                  createAt: "2017/11/23",
                                  rating: "4.4",
                                  totalViews: "2356.2")
        
        sut = DramasDetailViewModel(dramasModel)
        sut.load()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        
        sut = nil
    }
    
    func testOnline() {
        let promise = expectation(description: "Completion handler testOnline")
        
        sut.offline.observer { (offline) in
            XCTAssertFalse(offline, "目前為無網路狀態")
            promise.fulfill()
        }
        
        wait(for: [promise], timeout: 5)
    }

}
