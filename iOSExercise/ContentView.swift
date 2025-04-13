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
    @State private var selectedEndpoint: RecipeEndpoint = .All
    @State private var errorMessage: String?

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
            .toolbar {
                EndpointPicker(selectedEndpoint: $selectedEndpoint)
                    .onChange(of: selectedEndpoint) { _ in
                        Task { await refreshRecipes() }
                    }
            }
            .searchable(text: $ViewModel.searchText)
            .overlay {
                if ViewModel.searchResults.isEmpty {
                    VStack{
                        Image(systemName: "tray")
                            .resizable()
                            .frame(width: 25, height: 25)
                        Text("No results")
                        if let errorMessage = errorMessage {
                            Text(errorMessage)
                        }
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
        errorMessage = nil
        do {
            try await ViewModel.refresh(recipesFor: selectedEndpoint)
        } catch {
            errorMessage = "Something went wrong."
        }
    }
}

#Preview {
    ContentView()
}

