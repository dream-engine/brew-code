//
//  News.swift
//  Model
//
//  Created by Mohit Kumar Singh on 11/07/23.
//

import Foundation

// MARK: - WelcomeElement
public struct Beer: Codable {
    public let id: Int
    public let name, tagline, firstBrewed, description, contributedBy: String
    public let imageURL: String
    public let abv: Double
    public let ibu: Double?
    public let targetFg: Int
    public let targetOg: Double
    public let ebc: Int?
    public let srm, ph: Double?
    public let attenuationLevel: Double
    public let volume, boilVolume: BoilVolume
    public let method: Method
    public let ingredients: Ingredients
    public let foodPairing: [String]
    public let brewersTips: String

    enum CodingKeys: String, CodingKey {
        case id, name, tagline
        case firstBrewed = "first_brewed"
        case description
        case imageURL = "image_url"
        case abv, ibu
        case targetFg = "target_fg"
        case targetOg = "target_og"
        case ebc, srm, ph
        case attenuationLevel = "attenuation_level"
        case volume
        case boilVolume = "boil_volume"
        case method, ingredients
        case foodPairing = "food_pairing"
        case brewersTips = "brewers_tips"
        case contributedBy = "contributed_by"
    }
}

// MARK: - BoilVolume
public struct BoilVolume: Codable {
    public let value: Double
    public let unit: String
}

// MARK: - Ingredients
public struct Ingredients: Codable {
    public let malt: [Malt]
    public let hops: [Hop]
    public let yeast: String
}

// MARK: - Hop
public struct Hop: Codable {
    public let name, add, attribute: String
    public let amount: BoilVolume
}

// MARK: - Malt
public struct Malt: Codable {
    public let name: String
    public let amount: BoilVolume
}

// MARK: - Method
public struct Method: Codable {
    public let mashTemp: [MashTemp]
    public let fermentation: Fermentation
    public let twist: String?

    enum CodingKeys: String, CodingKey {
        case mashTemp = "mash_temp"
        case fermentation, twist
    }
}

// MARK: - Fermentation
public struct Fermentation: Codable {
    public let temp: BoilVolume
}

// MARK: - MashTemp
public struct MashTemp: Codable {
    public let temp: BoilVolume
    public let duration: Int?
}
