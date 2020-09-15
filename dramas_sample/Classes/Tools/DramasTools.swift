//
//  DramasTools.swift
//  dramas_sample
//
//  Created by Rock Chen on 2020/9/12.
//  Copyright © 2020 Rock Chen. All rights reserved.
//

import Foundation
import CoreData

// 提供戲劇Entity的新增、刪除、修改
class DramasTools {
    
    /// 新增
    func insert(_ dramas: [DramasData]) {
        let helper = CoreDataHelper.shared
        let context = helper.persistentContainer.viewContext
        
        dramas.forEach { (data) in
            let entity = NSEntityDescription.insertNewObject(forEntityName: "Dramas", into: context) as! Dramas
            
            entity.drama_id = Int32(data.drama_id)
            entity.rating = data.rating
            entity.name = data.name
            entity.total_views = Int32(data.total_views)
            entity.created_at = data.created_at
            entity.thumb = "\(data.thumb)"
        }
        
        helper.saveContext()
    }
    
    /// 取得資料
    func fetch(_ name: String? = nil) -> [Dramas] {
        let helper = CoreDataHelper.shared
        let context = helper.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Dramas")
        
        request.sortDescriptors = [NSSortDescriptor(key: "drama_id", ascending: true)]
        if let text = name {
            request.predicate = NSPredicate(format: "name CONTAINS[cd] %@", text)
        }
        
        do {
            let result = try context.fetch(request) as! [Dramas]
            
            return result
        } catch {
            fatalError("Failed to fetch employees: \(error)")
        }
    }
    
    /// 刪除所有資料
    func deleteAll() {
        let helper = CoreDataHelper.shared
        let context = helper.persistentContainer.viewContext
        let darams = fetch()
        
        darams.forEach { (entity) in
            context.delete(entity)
        }
        
        helper.saveContext()
    }
}
