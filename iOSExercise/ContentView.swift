//
//  ContentView.swift
//  iOSExercise
//
//  Created by Bryce Tome on 4/12/25.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @ObservedObject private var ViewModel = ContentViewModel()

    var body: some View {
        NavigationStack {
            List(ViewModel.searchResults, id: \.uuid) { recipe in
                NavigationLink(
                    destination: RecipeView(recipe: .constant(recipe)),
                    label: {
                        RecipeNavigationView(recipe: .constant(recipe))
                    }
                )
            }
            .navigationTitle("Recipes")
            .searchable(text: $ViewModel.searchText)
            .overlay {
                if ViewModel.searchResults.isEmpty, !ViewModel.searchText.isEmpty {
                    VStack{
                        Image(systemName: "magnifyingglass")
                            .resizable()
                            .frame(width: 25, height: 25)
                        Text("No results")
                    }
                }
            }
            .task {
                await refreshRecipes()

            }
            .refreshable {
                await refreshRecipes()
            }
        }
    }
    
    private func refreshRecipes() async {
        Task{
            ViewModel.recipes = try await fetchAllRecipes()
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

#Preview {
    ContentView()
}

