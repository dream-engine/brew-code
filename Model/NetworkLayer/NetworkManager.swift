//
//  NetworkManager.swift
//  Model
//
//  Created by Mohit Kumar Singh on 11/07/23.
//

import Foundation


/// Wrapper for Network Requests, has functions for various API Requests, and passes the queries to the Generic GET/POST functions.
struct NetworkManager {
    
    // MARK:- functions
    
    /// Fetches Array of Posts. Note that I've passed T as [Post]?
    func getPosts(onCompletion: @escaping ([Post]?, NetworkError?) -> ()) {
        APIRequestManager.makeGetRequest(path: "posts", queries: [:]) { (result: [Post]?, error) in
            onCompletion(result, error)
        }
    }
    
    /// Puts a post using POST API. Here T passed is [String : String]?
    func addPost(onCompletion: @escaping ([String: String]?, NetworkError?) -> ()) {
        /// hardcoded body for now
        let body: Parameters = [ "id": 101, "title": "Hello World", "body": "How you doin?", "userId": 1 ]
    
        APIRequestManager.makePostRequest(path: "/posts", body: body)  { ( result: [String: String]?, error) in
                onCompletion(result, error)
        }
    }
    
    func getBeers(onCompletion: @escaping ([Beer]?, NetworkError?) -> Void) {
        let router = BeerRouter.fetchBeerData
        APIRequestManager.makeGetRequest(path: router.path, queries: [:]) { (result, error) in
            onCompletion(result, error)
        }
    }
}

/// Models
///
/// for GET API
struct Post: Codable {
    let id: Int
    let userId: Int
    let title: String
    let body: String
}
