//
//  Experience.swift
//  Around Egypt
//
//  Created by Omar Mohamed on 14/10/2025.
//

import Foundation

struct Experience: Identifiable, Codable, Equatable {
    let id: Int
    let title: String
    let location: String?
    let description: String?
    let imageUrl: String?
    var likes: Int
    var views: Int
    var recommended: Bool?
    
    enum CodingKeys: String, CodingKey {
        case id, title, description, views, likes
        case location
        case imageUrl = "image_url"
        case recommended
    }
}
