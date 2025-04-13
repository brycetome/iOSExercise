//
//  Recipe.swift
//  iOSExercise
//
//  Created by Bryce Tome on 4/12/25.
//

import Foundation

public struct Recipe: Codable, Equatable {
    var cuisine: String
    var name: String
    var photo_url_large: String?
    var photo_url_small: String?
    var uuid: String
    var source_url: String?
    var youtube_url: String?
    
    public func getLargeImage() async -> Data? {
        return await getImage(imageName: getLargeImageName(), urlString: photo_url_large)
    }
    
    public func getSmallImage() async -> Data? {
        return await getImage(imageName: getSmallImageName(), urlString: photo_url_small)
    }
    
    private func getSmallImageName() -> String {
        return getImageName(size: "Small")
    }
    
    private func getLargeImageName() -> String {
        return getImageName(size: "Large")
    }
    
    private func getImageName(size: String) -> String {
        return "\(uuid)+\(size)"
    }
}

public struct RecipeGroup {
    var recipes: [Recipe]
    var title: String
}

let recipe1 = Recipe(cuisine: "Malaysian",
                     name: "Apam Balik",
                     photo_url_large: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/large.jpg",
                     photo_url_small: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/small.jpg",
                     uuid: "0c6ca6e7-e32a-4053-b824-1dbf749910d8",
                     source_url: "https://www.nyonyacooking.com/recipes/apam-balik~SJ5WuvsDf9WQ",
                     youtube_url: "https://www.youtube.com/watch?v=6R8ffRRJcrg")
