//
//  RecipeView.swift
//  iOSExercise
//
//  Created by Bryce Tome on 4/12/25.
//

import SwiftUI

struct RecipeView: View {
    @Binding var recipe: Recipe
    @State private var ImageData: Data?
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                if let ImageData = ImageData
                {
                    Image(uiImage: UIImage(data: ImageData) ?? UIImage())
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(10)
                }
                else {
                    ProgressView()
                        .task {
                            ImageData = await recipe.getLargeImage()
                        }
                }
                
                Text(recipe.cuisine)
                
                if let source_url_string = recipe.source_url,
                   let source_url = URL(string: source_url_string) {
                    Link("Original Recipe", destination: source_url)
                }
                
                if let youtube_url_string = recipe.youtube_url,
                   let youtube_url = URL(string: youtube_url_string) {
                    Link("Video", destination: youtube_url)
                }
                
                Spacer()
            }
            .padding(16)
        }
        .navigationTitle(recipe.name)
    }
}

#Preview {
    RecipeView(recipe: .constant(recipe1))
}
