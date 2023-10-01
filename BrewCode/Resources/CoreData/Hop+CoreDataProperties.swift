//
//  Hop+CoreDataProperties.swift
//  BrewCode
//
//  Created by Mohit Kumar Singh on 13/07/23.
//
//

import Foundation
import CoreData


extension Hop {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Hop> {
        return NSFetchRequest<Hop>(entityName: "Hop")
    }

    @NSManaged public var name: String?
    @NSManaged public var add: String?
    @NSManaged public var attribute: String?

}

extension Hop : Identifiable {

}
