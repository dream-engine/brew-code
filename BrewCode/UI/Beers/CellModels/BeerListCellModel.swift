//
//  BeerListCellModel.swift
//  BrewCode
//
//  Created by Mohit Kumar Singh on 12/07/23.
//

import Foundation
import Model

class BeerListCellModel {
    var beer: Beer
    
    init(beer: Beer) {
        self.beer = beer
    }
    
    var isFavourite: Bool {
        return self.beer.isFavourite
    }
    
    var tagline: String {
        return self.beer.tagline ?? ""
    }
    
    var name: String {
        return self.beer.name ?? ""
    }
    
    var imageUrlString: String? {
        return self.beer.imageUrl
    }
}
