//
//  Beer+CoreDataProperties.swift
//  BrewCode
//
//  Created by Mohit Kumar Singh on 13/07/23.
//
//

import Foundation
import CoreData


extension Beer {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Beer> {
        return NSFetchRequest<Beer>(entityName: "Beer")
    }

    @NSManaged public var id: Int64
    @NSManaged public var name: String?
    @NSManaged public var tagline: String?
    @NSManaged public var descript: String?
    @NSManaged public var contributedBy: String?
    @NSManaged public var imageUrl: String?
    @NSManaged public var brewersTips: String?
    @NSManaged public var ingredients: Ingredients?

}

extension Beer : Identifiable {

}
