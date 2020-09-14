//
//  Dramas+CoreDataProperties.swift
//  
//
//  Created by Rock Chen on 2020/9/14.
//
//

import Foundation
import CoreData


extension Dramas {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Dramas> {
        return NSFetchRequest<Dramas>(entityName: "Dramas")
    }

    @NSManaged public var created_at: Date?
    @NSManaged public var drama_id: Int32
    @NSManaged public var name: String?
    @NSManaged public var rating: Double
    @NSManaged public var thumb: String?
    @NSManaged public var total_views: Int32

}
