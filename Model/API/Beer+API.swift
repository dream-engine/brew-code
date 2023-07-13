//
//  News+API.swift
//  Model
//
//  Created by Mohit Kumar Singh on 11/07/23.
//

import Foundation

extension BeerResponse {
    
    /// Fetch List of beers
    /// - Parameter onCompletion: Returns List of Beers or Error
    public static func getBeers(onCompletion: @escaping ([BeerResponse]?, NetworkError?) -> Void) {
        let router = BeerRouter.fetchBeerData
        APIRequestManager.makeGetRequest(path: router.path, queries: [:]) { (result, error) in
            onCompletion(result, error)
        }
    }
}
