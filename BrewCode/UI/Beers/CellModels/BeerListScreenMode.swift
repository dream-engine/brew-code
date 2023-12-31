//
//  BeerListScreenMode.swift
//  BrewCode
//
//  Created by Mohit Kumar Singh on 13/07/23.
//

import Foundation

enum BeerListScreenMode {
    case favourite, list, search
    
    var title: String {
        switch self {
        case .favourite:
            return "Favourites"
        case .list:
            return "Beers"
        case .search:
            return ""
        }
    }
    
    var emptyDataImageName: String {
        switch self {
        case .favourite:
            return "heart.slash"
        case .list:
            return "xmark.icloud"
        case .search:
            return "magnifyingglass"
        }
    }
}
