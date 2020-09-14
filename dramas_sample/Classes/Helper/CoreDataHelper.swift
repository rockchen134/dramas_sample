//
//  CoreDataHelper.swift
//  dramas_sample
//
//  Created by Rock Chen on 2020/9/12.
//  Copyright © 2020 Rock Chen. All rights reserved.
//

import Foundation
import CoreData

final class CoreDataHelper: NSObject {
    static let shared = CoreDataHelper()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "dramas_sample")
        
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func saveContext() {
        let context = persistentContainer.viewContext
        
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
