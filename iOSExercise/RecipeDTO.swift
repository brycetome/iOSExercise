//
//  Recipe.swift
//  iOSExercise
//
//  Created by Bryce Tome on 4/12/25.
//

import Foundation

public struct RecipeDTO: Codable, Equatable {
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

public struct RecipeDTO
