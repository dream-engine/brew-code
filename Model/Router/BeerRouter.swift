//
//  NewsRouter.swift
//  Model
//
//  Created by Mohit Kumar Singh on 11/07/23.
//

import Foundation

enum BeerRouter {
    case fetchBeerData
    
    
    var path: String {
        switch self {
        case .fetchBeerData:
            return "beers"
        }
    }
    
    var params: [String: Any] {
        switch self {
        case .fetchBeerData:
            return [:]
        }
    }
}
