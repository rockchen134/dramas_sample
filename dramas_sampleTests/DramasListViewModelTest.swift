//
//  DramasListViewModelTest.swift
//  dramas_sampleTests
//
//  Created by Rock Chen on 2020/9/14.
//  Copyright © 2020 Rock Chen. All rights reserved.
//

import XCTest
@testable import dramas_sample

class DramasListViewModelTest: XCTestCase {

    var sut: DramasListViewModel!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sut = DramasListViewModel()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
    }

    func testLoad() {
        UserDefaults.standard.setValue("", forKey: "searchText")
        UserDefaults.standard.synchronize()
        
        let promise = expectation(description: "Completion handler testLoad")
        
        sut.status.observer { (status) in
            switch status {
            case .none:
                XCTAssertTrue(true)
            case .start:
                XCTAssertTrue(true)
            case .completed:
                XCTAssertTrue((self.sut.searchText == ""), "搜尋字串不為空")
                XCTAssertNotNil(self.sut.dataSource.count == 6, "資料錯誤")
                promise.fulfill()
            case .error(_):
                XCTAssertTrue(true)
            }
        }
        sut.load()
        wait(for: [promise], timeout: 5)
    }
    
    func testSearchLoad() {
        UserDefaults.standard.setValue("我", forKey: "searchText")
        UserDefaults.standard.synchronize()
                
        let promise = expectation(description: "Completion handler testSearchLoad")
        
        sut.status.observer { [unowned self] (status) in
            switch status {
            case .none:
                XCTAssertTrue(true)
            case .start:
                XCTAssertTrue(true)
            case .completed:
                XCTAssertTrue((self.sut.searchText == "我"), "搜尋字串不相等")
                XCTAssertNotNil(self.sut.filterDataSource.count == 1, "搜尋結果錯誤")
                promise.fulfill()
            case .error(_):
                XCTAssertTrue(true)
            }
        }
        sut.load()
        wait(for: [promise], timeout: 5)
    }
    
    func testSearch() {
        UserDefaults.standard.setValue("", forKey: "searchText")
        UserDefaults.standard.synchronize()
        
        let promise = expectation(description: "Completion handler testSearch")
                
        sut.searchResult.observer { (searchResult) in
            if searchResult {
                XCTAssertNotNil(self.sut.filterDataSource.count == 1, "搜尋結果錯誤")
                promise.fulfill()
            } else {
                XCTAssertNotNil(self.sut.filterDataSource.count == 0, "搜尋結果錯誤")
            }
        }
        sut.load()
        sut.search("我")
        wait(for: [promise], timeout: 5)
    }
}
