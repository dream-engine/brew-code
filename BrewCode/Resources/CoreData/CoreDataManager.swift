//
//  CoreDataManager.swift
//  BrewCode
//
//  Created by Mohit Kumar Singh on 13/07/23.
//

import Foundation
import CoreData
import Model

class CoreDataManager {
    static let shared = CoreDataManager()
    
//    let context = persistentContainer.viewContext
    
    private init() {}
    
    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "BrewCode")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func updateBeersData(withResponse beerResponse: [BeerResponse], completion: @escaping (_ updated: Bool)->Void) {
        let context = persistentContainer.viewContext
        // Fetch already saved data
        var storedData = self.fetchBeers()
        var didUpdateData = false
        beerResponse.forEach { beerEntity in
            if storedData.filter({ $0.id == beerEntity.id }).first == nil {
                // Beer
                let beer = NSEntityDescription.insertNewObject(forEntityName: "Beer", into: context) as! Beer
                
                let ingredients = NSEntityDescription.insertNewObject(forEntityName: "Ingredients", into: context) as! Ingredients
                var hopData = Set<Hop>()
                beerEntity.ingredients.hops.forEach { hopEntity in
                    let hop = NSEntityDescription.insertNewObject(forEntityName: "Hop", into: context) as! Hop
                    hop.name = hopEntity.name
                    hop.add = hopEntity.add
                    hop.attribute = hopEntity.attribute
                    hopData.insert(hop)
                }
                
                var maltData = Set<Malt>()
                beerEntity.ingredients.malt.forEach { maltEntity in
                    let malt = NSEntityDescription.insertNewObject(forEntityName: "Malt", into: context) as! Malt
                    malt.name = maltEntity.name
                    
                    maltData.insert(malt)
                }
                
                ingredients.malt = maltData as NSSet
                ingredients.hops = hopData as NSSet
                ingredients.yeast = beerEntity.ingredients.yeast
                
                beer.ingredients = ingredients
                beer.id = Int64(beerEntity.id)
                beer.name = beerEntity.name
                beer.tagline = beerEntity.tagline
                beer.descript = beerEntity.description
                beer.contributedBy = beerEntity.contributedBy
                beer.imageUrl = beerEntity.imageURL
                beer.brewersTips = beerEntity.brewersTips
                
                do {
                    try context.save()
                    print("Saved \(beerEntity.name) in Core Data")
                   didUpdateData = true
                } catch {
                    print("Couldn't save: ", error.localizedDescription)
                }
            }
        }
        completion(didUpdateData)
    }
    
    func fetchBeers() -> [Beer] {
        let context = persistentContainer.viewContext
        // Fetch already saved data
        var storedData = [Beer]()
        
        do {
            storedData = try context.fetch(Beer.fetchRequest())
        } catch {
            print("Couldn't fetch: ", error.localizedDescription)
        }
        
        return storedData
    }
}
