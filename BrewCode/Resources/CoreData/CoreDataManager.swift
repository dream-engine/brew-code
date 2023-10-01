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
    
    private init() {}
    
    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "BrewCode")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
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
                
                // Ingredients
                let ingredients = NSEntityDescription.insertNewObject(forEntityName: "Ingredients", into: context) as! Ingredients
                
                // Hops Set
                var hopData = Set<Hop>()
                beerEntity.ingredients.hops.forEach { hopEntity in
                    let hop = NSEntityDescription.insertNewObject(forEntityName: "Hop", into: context) as! Hop
                    hop.name = hopEntity.name
                    hop.add = hopEntity.add
                    hop.attribute = hopEntity.attribute
                    hopData.insert(hop)
                }
                
                // Malts Set
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
    
    /// Fetch Beer Objects from CoreData
    /// - Returns: Array of Beer
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
    
    /// Update Favourite in CoreData
    /// - Parameters:
    ///   - isFavourite: Bool
    ///   - id: Id of Beer Entity
    func updateFavourite(withFavourite isFavourite: Bool, forId id: Int64) {
        let context = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Beer")
        fetchRequest.predicate = NSPredicate(format: "id = %@", "\(id)")
        
        do {
            let results = try context.fetch(fetchRequest)
            if let requiredBeer = results.first as? Beer {
                requiredBeer.isFavourite = isFavourite
            }
            
            try context.save()
        } catch {
            print("Couldn't fetch from CoreData ", error.localizedDescription)
        }
    }
}
