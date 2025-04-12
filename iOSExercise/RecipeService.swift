//
//  RecipeEndPoints.swift
//  iOSExercise
//
//  Created by Bryce Tome on 4/12/25.
//

import Foundation

public struct RecipeResponse: Codable {
    var recipes: [Recipe]
}

var AllRecipes: String = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json"
var MalformedRecipes: String = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-malformed.json"
var EmptyData: String = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-empty.json"

public func fetchAllRecipes() async throws -> [Recipe] {
    return try await fetchRecipesFromURLString(urlString: AllRecipes)
}

public func fetchMalformedRecipes() async throws -> [Recipe] {
    return try await fetchRecipesFromURLString(urlString: MalformedRecipes)
}

public func fetchEmptyRecipes() async throws -> [Recipe] {
    return try await fetchRecipesFromURLString(urlString: EmptyData)
}

private func fetchRecipesFromURLString(urlString: String) async throws -> [Recipe] {
    guard let url = URL(string:  urlString) else {
        throw NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "All Recipes URL is invalid"])
    }
    
    let (data, _) = try await URLSession.shared.data(from: url)
    
    return try JSONDecoder().decode(RecipeResponse.self, from: data).recipes
}
