//
//  Ingredients+CoreDataProperties.swift
//  BrewCode
//
//  Created by Mohit Kumar Singh on 13/07/23.
//
//

import Foundation
import CoreData


extension Ingredients {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Ingredients> {
        return NSFetchRequest<Ingredients>(entityName: "Ingredients")
    }

    @NSManaged public var yeast: String?
    @NSManaged public var hops: NSSet?
    @NSManaged public var malt: NSSet?

}

// MARK: Generated accessors for hops
extension Ingredients {

    @objc(addHopsObject:)
    @NSManaged public func addToHops(_ value: Hop)

    @objc(removeHopsObject:)
    @NSManaged public func removeFromHops(_ value: Hop)

    @objc(addHops:)
    @NSManaged public func addToHops(_ values: NSSet)

    @objc(removeHops:)
    @NSManaged public func removeFromHops(_ values: NSSet)

}

// MARK: Generated accessors for malt
extension Ingredients {

    @objc(addMaltObject:)
    @NSManaged public func addToMalt(_ value: Malt)

    @objc(removeMaltObject:)
    @NSManaged public func removeFromMalt(_ value: Malt)

    @objc(addMalt:)
    @NSManaged public func addToMalt(_ values: NSSet)

    @objc(removeMalt:)
    @NSManaged public func removeFromMalt(_ values: NSSet)

}

extension Ingredients : Identifiable {

}
