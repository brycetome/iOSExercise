//
//  RecipeNavigationViewModel.swift
//  iOSExercise
//
//  Created by Bryce Tome on 4/12/25.
//

import Foundation

@MainActor
public class ContentViewModel: ObservableObject {
    @Published var searchText: String = ""
    @Published var recipes: [Recipe] = []
    
    var searchResults: [Recipe] {
        let recipes = recipes.sorted { $0.name < $1.name }
        
        if searchText.isEmpty {
            return recipes
        } else {
            return recipes.filter { $0.name.contains(searchText) }
        }
    }
    
    func refresh(recipesFor: RecipeEndpoint) async throws {
        do {
            recipes = try await recipesFor.getRecipes()
        } catch {
            recipes.removeAll()
            throw error
        }
    }
}
