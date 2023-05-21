//
//  BusinessModel.swift
//  Yelp Business
//
//  Created by mmbs on 21/05/23.
//

import Foundation

import Foundation

// MARK: - NewsDetailModel
public struct BusinessModel: Codable, Hashable {
    let businesses: [Business]
    let total: Int
}

// MARK: - Business
struct Business: Codable, Hashable {
    
    let id, alias, name: String
    let imageURL: String
    let isClosed: Bool
    let reviewCount: Int
    let categories: [Category]
    let rating: Double
    let price: String?
    let location: Location
    let phone: String?
    let distance: Double
    let displayPhone: String?
    
    
    

    enum CodingKeys: String, CodingKey {
        case id, alias, name
        case imageURL = "image_url"
        case isClosed = "is_closed"
        case reviewCount = "review_count"
        case categories, rating, price, location, phone, distance
        case displayPhone = "display_phone"
       
    }
}

// MARK: - Category
struct Category: Codable, Hashable {
    let alias, title: String
}

// MARK: - Location
struct Location: Codable, Hashable {
    let address1: String?
    let displayAddress: [String]

    enum CodingKeys: String, CodingKey {
        case displayAddress = "display_address"
        case address1
    }
}
