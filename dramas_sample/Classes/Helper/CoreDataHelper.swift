//
//  CoreDataHelper.swift
//  dramas_sample
//
//  Created by Rock Chen on 2020/9/12.
//  Copyright © 2020 Rock Chen. All rights reserved.
//

import Foundation
import CoreData

/// Core Data stack
final class CoreDataHelper: NSObject {
    /// Get global instance
    static let shared = CoreDataHelper()
    
    /**
     The persistent container for the application. This implementation
     creates and returns a container, having loaded the store for the
     application to it. This property is optional since there are legitimate
     error conditions that could cause the creation of the store to fail.
     */
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "dramas_sample")
        
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    /**
     Save the entity in the main context.
    */
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
