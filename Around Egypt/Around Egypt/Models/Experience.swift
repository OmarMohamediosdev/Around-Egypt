//
//  Experience.swift
//  Around Egypt
//
//  Created by Omar Mohamed on 14/10/2025.
//

import Foundation

// MARK: - Experience
nonisolated struct Experience: Codable {
    let data: [ExperienceDatum]?
}

// MARK: - Datum
nonisolated struct ExperienceDatum: Codable, Identifiable {
    let id, title: String?
    let coverPhoto: String?
    let description: String?
    let viewsNo, recommended: Int?
    let city: City?
    var likesNo: Int?
    var isLiked: Bool?

    enum CodingKeys: String, CodingKey {
        case id, title
        case coverPhoto = "cover_photo"
        case description
        case viewsNo = "views_no"
        case likesNo = "likes_no"
        case recommended, city
        case isLiked = "is_liked"
    }
}

// MARK: - City
struct City: Codable {
    let id: Int?
    let name: String?
    let topPick: Int?

    enum CodingKeys: String, CodingKey {
        case id, name
        case topPick = "top_pick"
    }
}


// MARK: - Mock for Previews
let mockData = ExperienceDatum(
    id: "1",
    title: "Nubian House",
    coverPhoto: "nubian",
    description: "Traditional Nubian house experience",
    viewsNo: 156,
    recommended: 1,
    city: City(id: 1, name: "Aswan", topPick: 1),
    likesNo: 372,
    isLiked: false
)
