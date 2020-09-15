//
//  CoreDataTest.swift
//  dramas_sampleTests
//
//  Created by Rock Chen on 2020/9/15.
//  Copyright © 2020 Rock Chen. All rights reserved.
//

import XCTest
import CoreData
@testable import dramas_sample

class CoreDataTest: XCTestCase {

    var sut: DramasTools!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sut = DramasTools()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
    }

    func testInsert() {
        flushData()
        
        if let path = Bundle.main.path(forResource: "dramas-sample", ofType: "json"), let data = try? String(contentsOfFile: path).data(using: .utf8) {
            
            let decoder = JSONDecoder()
            
            decoder.dateDecodingStrategy = .formatted(DateFormatter.iso8601Full)
            
            let model = try? decoder.decode(DramasResponse.self, from: data)
            
            if let dramas = model?.data {
                sut.insert(dramas)
            }
            
            XCTAssertEqual(numberOfItemsInPersistentStore(), 6)
        }
    }

    func testFetchAll() {
        let result = sut.fetch()
        
        XCTAssertEqual(result.count, 6)
    }
    
    func testRemove() {
        if numberOfItemsInPersistentStore() == 6 {
            sut.deleteAll()
            XCTAssertEqual(numberOfItemsInPersistentStore(), 0)
        }
    }
        
    func flushData() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest<NSFetchRequestResult>(entityName: "Dramas")
        let objs = try! CoreDataHelper.shared.persistentContainer.viewContext.fetch(fetchRequest)
        for case let obj as NSManagedObject in objs {
            CoreDataHelper.shared.persistentContainer.viewContext.delete(obj)
        }
        
        CoreDataHelper.shared.saveContext()
    }
    
    func numberOfItemsInPersistentStore() -> Int {
        let request: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Dramas")
        let results = try! CoreDataHelper.shared.persistentContainer.viewContext.fetch(request)
        return results.count
    }
}
