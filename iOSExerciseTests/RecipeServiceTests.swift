//
//  iOSExerciseTests.swift
//  iOSExerciseTests
//
//  Created by Bryce Tome on 4/12/25.
//

import Testing
import Foundation

@testable import iOSExercise

struct RecipeServiceTests {
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
