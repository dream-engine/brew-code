//
//  BeerListViewModel2.swift
//  BrewCode
//
//  Created by Mohit Kumar Singh on 22/07/23.
//

import Foundation
import Model

// MARK: BeerListViewModel2
class BeerListViewModel2: ObservableObject {
    @Published var beers = [BeerListCellModel]()
    
    @Published var filterSet: [String] = []
    
    init() {
    }
}

// MARK: Helper Functions
extension BeerListViewModel2 {
    
    func filteredBeers(forHop hopName: String) -> [BeerListCellModel] {

        if hopName == "All" {
            return self.beers
        } else {
            return beers.filter { beer in
                var isAvailable = false
                beer.beer.ingredients?.hops?.forEach({ hop in

                    if ((hop as? Hop)?.name ?? "") == hopName {
                        isAvailable = true
                    }
                })

                return isAvailable
            }
        }
    }
    
//    func getFilterData() -> [BeerSegmentCollectionCellModel] {
//
//        var filters: [BeerSegmentCollectionCellModel] = []
//        let allFilter = BeerSegmentCollectionCellModel(title: "All", isSelected: self.beerFilter == "All")
//        filters.append(allFilter)
//
//        filters.append(contentsOf: self.filterSet
//            .map({ BeerSegmentCollectionCellModel(
//                title: $0,
//                isSelected: $0 == self.beerFilter )}
//                )
//                .sorted(by: { $0.title < $1.title })
//        )
//
//        return filters
//    }
    
    func updateFilterSet() {
        self.filterSet = []
        self.beers.forEach { beer in
            beer.beer.ingredients?.hops?.forEach { hop in
                if self.filterSet.contains((hop as? Hop)?.name  ?? "") {
                    
                } else {
                    self.filterSet.append((hop as? Hop)?.name  ?? "")
                }
            }
        }
        
        self.filterSet.sort(by: <)
        self.filterSet.insert("All", at: 0)
    }
}

// MARK: Fetch Data
extension BeerListViewModel2 {
    
    func fetchBeers() {
        self.beers = CoreDataManager.shared.fetchBeers().map({ BeerListCellModel(beer: $0)})
        self.updateFilterSet()
        BeerResponse.getBeers { [weak self] (beersResponse, error) in
            guard let self = self else { return }
            
            if let beersResponse {
                CoreDataManager.shared.updateBeersData(withResponse: beersResponse) { [weak self] updated in
                    guard let self = self else { return }
                    
                    if updated {
                        DispatchQueue.main.async {
                            self.beers = CoreDataManager.shared.fetchBeers().map({ BeerListCellModel(beer: $0)})
                            self.updateFilterSet()
                        }
                    }
                }
            } else {
                if let error {
                    switch error {
                    case .noInternet: ()
//                        self.view?.showNoInternetToast(withMessage: error.errorMessage)
                    default: ()
                    }
                }
            }
        }
    }
    
   
}
