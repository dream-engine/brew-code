//
//  BeerListViewModel.swift
//  BrewCode
//
//  Created by Mohit Kumar Singh on 11/07/23.
//

import Foundation
import Model

protocol BeerListViewModelProtocol: AnyObject {
    func reload()
}

class BeerListViewModel {
    weak var view: BeerListViewModelProtocol?
    
    // Data
    var beers: [Beer] = []
    
    init(view: BeerListViewModelProtocol) {
        self.view = view
    }
}

// MARK: Helper Functions
extension BeerListViewModel {
    private func prepareCellModels() {
        print(beers)
    }
}

// MARK: BeerListViewControllerProtocol
extension BeerListViewModel: BeerListViewControllerProtocol {
    func fetchBeers() {
        Beer.getBeers { [weak self] (beers, error) in
            guard let self = self else { return }
            
            if let beers {
                self.beers = beers
                self.prepareCellModels()
            } else {
                // Handle error
            }
        }
    }
}
