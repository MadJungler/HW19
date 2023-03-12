//
//  Executor+CoreDataProperties.swift
//  HW19
//
//  Created by Павел on 11.03.2023.
//
//

import Foundation
import CoreData


extension Executor {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Executor> {
        return NSFetchRequest<Executor>(entityName: "Executor")
    }

    @NSManaged public var name: String?
    @NSManaged public var country: String?
    @NSManaged public var age: Int16
    @NSManaged public var surname: String?
    @NSManaged public var id: String?

}

//extension Executor : Identifiable {
//
//}
