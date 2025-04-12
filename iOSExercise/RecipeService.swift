//
//  RecipeEndPoints.swift
//  iOSExercise
//
//  Created by Bryce Tome on 4/12/25.
//

import Foundation

public struct RecipeResponse: Codable {
    var recipes: [RecipeData]
}

public struct RecipeData: Codable, Equatable {
    var cuisine: String
    var name: String
    var photo_url_large: String?
    var photo_url_small: String?
    var uuid: String
    var source_url: String?
    var youtube_url: String?
}

var AllRecipes: String = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json"
var MalformedRecipes: String = ""
var EmptyData: String = ""

func fetchRecipesFromURL() async throws -> [RecipeData] {
    
    guard let url = URL(string:  AllRecipes) else {
        throw NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "All Recipes URL is invalid"])
    }
    
    let (data, _) = try await URLSession.shared.data(from: url)
//    guard let httpResponse = response as? HTTPURLResponse else {
//        throw NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to retrieve HTTP response"])
//    }
    
    do {
        return try JSONDecoder().decode(RecipeResponse.self, from: data).recipes
    } catch {
        throw NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to decode JSON"])
    }
}
