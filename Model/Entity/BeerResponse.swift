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

var test = """
 
 (id: 25, name: "Bad Pixie", tagline: "Spiced Wheat Beer.", firstBrewed: "10/2008", description: "2008 Prototype beer, a 4.7% wheat ale with crushed juniper berries and citrus peel.", contributedBy: "Sam Mason <samjbmason>", imageURL: "https://images.punkapi.com/v2/25.png", abv: 4.7, ibu: Optional(45.0), targetFg: 1010, targetOg: 1047.0, ebc: Optional(8), srm: Optional(4.0), ph: Optional(4.4), attenuationLevel: 79.0, volume: Model.BoilVolume(value: 20.0, unit: "litres"), boilVolume: Model.BoilVolume(value: 25.0, unit: "litres"), method: Model.Method(mashTemp: [Model.MashTemp(temp: Model.BoilVolume(value: 67.0, unit: "celsius"), duration: Optional(75))], fermentation: Model.Fermentation(temp: Model.BoilVolume(value: 19.0, unit: "celsius")), twist: Optional("Crushed juniper berries: 12.5g, Lemon peel: 18.8g")), ingredients: Model.Ingredients(malt: [Model.Malt(name: "Wheat", amount: Model.BoilVolume(value: 2.5, unit: "kilograms")), Model.Malt(name: "Extra Pale", amount: Model.BoilVolume(value: 2.06, unit: "kilograms"))], hops: [Model.Hop(name: "First Gold", add: "start", attribute: "bitter", amount: Model.BoilVolume(value: 18.75, unit: "grams")), Model.Hop(name: "First Gold", add: "end", attribute: "flavour", amount: Model.BoilVolume(value: 25.0, unit: "grams")), Model.Hop(name: "Sorachi Ace", add: "end", attribute: "flavour", amount: Model.BoilVolume(value: 16.25, unit: "grams"))], yeast: "Wyeast 1056 - American Ale™"), foodPairing: ["Poached sole fillet with capers", "Summer fruit salad", "Banana split"], brewersTips: "Make sure you have plenty of room in the fermenter. Beers containing wheat can often foam aggressively during fermentation.")
 """
