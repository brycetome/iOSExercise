//
//  iOSExerciseTests.swift
//  iOSExerciseTests
//
//  Created by Bryce Tome on 4/12/25.
//

import Testing
import Foundation

@testable import iOSExercise

struct iOSExerciseTests {
    
    let recipe1 = RecipeData(cuisine: "Malaysian",
                             name: "Apam Balik",
                             photo_url_large: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/large.jpg",
                             photo_url_small: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/small.jpg",
                             uuid: "0c6ca6e7-e32a-4053-b824-1dbf749910d8",
                             source_url: "https://www.nyonyacooking.com/recipes/apam-balik~SJ5WuvsDf9WQ",
                             youtube_url: "https://www.youtube.com/watch?v=6R8ffRRJcrg")
    let recipesCount = 63

    @Test func RecipesCount() async throws {
        let recipes = try await fetchAllRecipes()
        #expect(recipes.count == recipesCount)
    }
    
    @Test func FirstRecipe() async throws {
        let recipes = try await fetchAllRecipes()
        #expect(recipes[0] == recipe1)
    }
    
    @Test func Malformed() async throws {
        await #expect(throws: DecodingError.self) {
            try await fetchMalformedRecipes()
        }
    }
    
    @Test func EmptyRecipes() async throws {
        let recipes = try await fetchEmptyRecipes()
        #expect(recipes.count == 0)
    }
}
