//
//  News.swift
//  Model
//
//  Created by Mohit Kumar Singh on 11/07/23.
//

import Foundation

// MARK: - WelcomeElement
public struct BeerResponse: Codable {
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
    public let volume, boilVolume: BoilVolumeResponse
    public let method: MethodResponse
    public let ingredients: IngredientsResponse
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
public struct BoilVolumeResponse: Codable {
    public let value: Double
    public let unit: String
}

// MARK: - Ingredients
public struct IngredientsResponse: Codable {
    public let malt: [MaltResponse]
    public let hops: [HopResponse]
    public let yeast: String
}

// MARK: - Hop
public struct HopResponse: Codable {
    public let name, add, attribute: String
    public let amount: BoilVolumeResponse
}

// MARK: - Malt
public struct MaltResponse: Codable {
    public let name: String
    public let amount: BoilVolumeResponse
}

// MARK: - Method
public struct MethodResponse: Codable {
    public let mashTemp: [MashTempResponse]
    public let fermentation: FermentationResponse
    public let twist: String?

    enum CodingKeys: String, CodingKey {
        case mashTemp = "mash_temp"
        case fermentation, twist
    }
}

// MARK: - Fermentation
public struct FermentationResponse: Codable {
    public let temp: BoilVolumeResponse
}

// MARK: - MashTemp
public struct MashTempResponse: Codable {
    public let temp: BoilVolumeResponse
    public let duration: Int?
}
