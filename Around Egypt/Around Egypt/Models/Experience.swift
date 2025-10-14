//
//  Experience.swift
//  Around Egypt
//
//  Created by Omar Mohamed on 14/10/2025.
//

import Foundation

struct Experience: Identifiable {
    let id = UUID()
    let title: String
    let location: String
    let imageName: String
    let views: Int
    let likes: Int
    let isRecommended: Bool
    let description: String
}

let sampleExperiences = [
    Experience(title: "Nubian House",
               location: "Aswan, Egypt",
               imageName: "nubian",
               views: 156,
               likes: 372,
               isRecommended: true,
               description: "A colorful Nubian house experience."),
    
    Experience(title: "Egyptian Desert",
               location: "Egypt",
               imageName: "desert",
               views: 156,
               likes: 45,
               isRecommended: false,
               description: "Experience the vast Egyptian desert in 360 degrees."),
    
    Experience(title: "Pyramids of Giza",
               location: "Cairo, Egypt",
               imageName: "pyramids",
               views: 156,
               likes: 45,
               isRecommended: false,
               description: "Explore the ancient Pyramids of Giza up close.")
]
