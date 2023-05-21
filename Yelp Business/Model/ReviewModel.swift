//
//  ReviewModel.swift
//  Yelp Business
//
//  Created by mmbs on 21/05/23.
//

import Foundation

// MARK: - ReviewModel
struct ReviewModel: Codable, Hashable {
    let reviews: [Review]
    let total: Int
}

// MARK: - Review
struct Review: Codable, Hashable {
    let id: String
    let url: String
    let text: String
    let rating: Double
    let timeCreated: String
    let user: User

    enum CodingKeys: String, CodingKey {
        case id, url, text, rating
        case timeCreated = "time_created"
        case user
    }
}

// MARK: - User
struct User: Codable, Hashable {
    let id: String
    let profileURL: String?
    let imageURL: String?
    let name: String

    enum CodingKeys: String, CodingKey {
        case id
        case profileURL = "profile_url"
        case imageURL = "image_url"
        case name
    }
}
