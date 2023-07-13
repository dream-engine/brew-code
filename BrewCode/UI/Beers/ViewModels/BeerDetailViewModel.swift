//
//  BeerDetailViewModel.swift
//  BrewCode
//
//  Created by Mohit Kumar Singh on 13/07/23.
//

import Foundation

protocol BeerDetailViewModelProtocol: AnyObject {
    
}

class BeerDetailViewModel {
    weak var view: BeerDetailViewModelProtocol?
    
    init(view: BeerDetailViewModelProtocol) {
        self.view = view
    }
}
