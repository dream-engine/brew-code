//
//  BeerListViewModel.swift
//  BrewCode
//
//  Created by Mohit Kumar Singh on 11/07/23.
//

import Foundation
import Model

// MARK: BeerListViewModelProtocol
protocol BeerListViewModelProtocol: AnyObject {
    func reload()
}

// MARK: BeerListViewModel
class BeerListViewModel {
    weak var view: BeerListViewModelProtocol?
    
    var sectionModels: [SectionModel] = []
    
    var beerFilter = "All"
    
    // Data
    var beers: [Beer] = []
    
    var filterSet: Set<String> = []
    
    init(view: BeerListViewModelProtocol) {
        self.view = view
        
    }
}

// MARK: Helper Functions
extension BeerListViewModel {
    private func prepareCellModels() {
        print(self.beers)
        self.sectionModels = []
        
        let beerSegmentHeaderModel = BeerSegmentHeaderCellModel(cellModels: self.getFilterData())
        
        let beerListCellModels = self.filteredBeers()
            .map({ BeerListCellModel(beer: $0)})
            .sorted(by: { ($0.beer.name ?? "") < ($1.beer.name ?? "") })
        
        self.sectionModels.append(SectionModel(
            headerModel: beerSegmentHeaderModel,
            cellModels: beerListCellModels
        ))
        
        self.view?.reload()
    }
    
    func filteredBeers() -> [Beer] {
        
        if beerFilter == "All" {
            return self.beers
        } else {
            return beers.filter { beer in
                var isAvailable = false
                beer.ingredients?.hops?.forEach({ hop in
                    
                    if ((hop as? Hop)?.name ?? "") == self.beerFilter {
                        isAvailable = true
                    }
                })
                
                return isAvailable
            }
        }
    }
    
    func getFilterData() -> [BeerSegmentCollectionCellModel] {
        
        var filters: [BeerSegmentCollectionCellModel] = []
        let allFilter = BeerSegmentCollectionCellModel(title: "All", isSelected: self.beerFilter == "All")
        filters.append(allFilter)
        
        filters.append(contentsOf: self.filterSet
            .map({ BeerSegmentCollectionCellModel(
                title: $0,
                isSelected: $0 == self.beerFilter )}
                )
                .sorted(by: { $0.title < $1.title })
        )
        
        return filters
    }
    
    func updateFilterSet() {
        self.beers.forEach { beer in
            beer.ingredients?.hops?.forEach { hop in
                self.filterSet.insert((hop as? Hop)?.name  ?? "")
            }
        }
    }
}

// MARK: BeerListViewControllerProtocol
extension BeerListViewModel: BeerListViewControllerProtocol {
    
    func fetchBeers() {
        self.beers = CoreDataManager.shared.fetchBeers()
        self.updateFilterSet()
        self.prepareCellModels()
        BeerResponse.getBeers { [weak self] (beersResponse, error) in
            guard let self = self else { return }
            
            if let beersResponse {
                CoreDataManager.shared.updateBeersData(withResponse: beersResponse) { [weak self] updated in
                    guard let self = self else { return }
                    
                    if updated {
                        self.beers = CoreDataManager.shared.fetchBeers()
                        self.updateFilterSet()
                        self.prepareCellModels()
                        print("Updating data using Core data")
                    }
                }
            }
        }
    }
    
    var numberOfSections: Int {
        return self.sectionModels.count
    }
    
    func numberOfRows(inSection section: Int) -> Int {
        return self.sectionModels[section].cellModels.count
    }
    
    func item(atIndexPath indexPath: IndexPath) -> Any {
        return self.sectionModels[indexPath.section].cellModels[indexPath.row]
    }
    
    func headerItem(atSection section: Int) -> Any? {
        return self.sectionModels[section].headerModel
    }
    
    func didSelect(filter: String) {
        self.beerFilter = filter
        self.prepareCellModels()
    }
    
    func didUpdate(favourite isFavourite: Bool, forId id: Int64) {
        let beer = self.beers.filter({ $0.id == id }).first
        beer?.isFavourite = isFavourite
        CoreDataManager.shared.updateFavourite(withFavourite: isFavourite, forId: id)
    }
}
