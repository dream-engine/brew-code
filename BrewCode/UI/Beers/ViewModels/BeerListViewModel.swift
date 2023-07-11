//
//  BeerListViewModel.swift
//  BrewCode
//
//  Created by Mohit Kumar Singh on 11/07/23.
//

import Foundation

protocol BeerListViewModelProtocol: AnyObject {
    func reload()
}

class BeerListViewModel {
    weak var view: BeerListViewModelProtocol?
    
    init(view: BeerListViewModelProtocol) {
        self.view = view
    }
}

// MARK: Helper Functions
extension BeerListViewModel {
    private func prepareCellModels() {
        
    }
}

// MARK: BeerListViewControllerProtocol
extension BeerListViewModel: BeerListViewControllerProtocol {
    
}
