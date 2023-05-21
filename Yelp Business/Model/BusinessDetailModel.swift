//
//  BusinessDetailModel.swift
//  Yelp Business
//
//  Created by mmbs on 21/05/23.
//

import Foundation

struct BusinessDetailModel: Codable {
    let id, alias, name: String
    let imageURL: String
    let isClaimed, isClosed: Bool
    let url: String
    let phone, displayPhone: String
    let reviewCount: Int
    let categories: [Category]
    let rating: Double
    let location: Location
    let coordinates: Coordinates
    let photos: [String]
    let price: String?

    enum CodingKeys: String, CodingKey {
        case id, alias, name
        case imageURL = "image_url"
        case isClaimed = "is_claimed"
        case isClosed = "is_closed"
        case url, phone
        case displayPhone = "display_phone"
        case reviewCount = "review_count"
        case categories, rating, location, coordinates, photos, price
    }
}


// MARK: - Coordinates
struct Coordinates: Codable {
    let latitude, longitude: Double
}

// MARK: - Location
