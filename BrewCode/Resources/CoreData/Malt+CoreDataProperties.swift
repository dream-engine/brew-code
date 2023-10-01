//
//  Malt+CoreDataProperties.swift
//  BrewCode
//
//  Created by Mohit Kumar Singh on 13/07/23.
//
//

import Foundation
import CoreData


extension Malt {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Malt> {
        return NSFetchRequest<Malt>(entityName: "Malt")
    }

    @NSManaged public var name: String?

}

extension Malt : Identifiable {

}
