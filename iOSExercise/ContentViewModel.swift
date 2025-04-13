//
//  RecipeNavigationViewModel.swift
//  iOSExercise
//
//  Created by Bryce Tome on 4/12/25.
//


extension ContentView {
    public class ContentViewModel: ObservableObject {
        
        
        var searchResults: [Recipe] {
            let recipes = recipes.sorted { $0.name < $1.name }
            
            if searchText.isEmpty {
                return recipes
            } else {
                return recipes.filter { $0.name.contains(searchText) }
            }
        }
        
        
        private func fetchRecipes() async {
            Task {
                recipes = try await fetchAllRecipes()
            }
        }
        
    }
}
