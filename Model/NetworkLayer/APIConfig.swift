//
//  APIConfig.swift
//  Model
//
//  Created by Mohit Kumar Singh on 14/07/23.
//

import Foundation

/// API Config File
class APIConfig {
    /// Base URL
    static let baseUrl: String = APIUrl.domain
    
    /// API URL based on environment
    public struct APIUrl {
        #if DEBUG
        static let domain = APIUrl.qa
        #elseif RELEASE
        static let domain = APIUrl.prod
        #endif
        
        private static let dev = "https://api.punkapi.com/v2/"
        private static let qa = "https://api.punkapi.com/v2/"
        private static let prod = "https://api.punkapi.com/v2/"
    }
}
