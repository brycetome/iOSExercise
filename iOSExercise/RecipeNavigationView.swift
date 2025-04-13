//
//  SwiftUIView.swift
//  iOSExercise
//
//  Created by Bryce Tome on 4/12/25.
//

import SwiftUI

struct RecipeNavigationView: View {
    @Binding var recipe: Recipe
    @State private var ImageData: Data?
    
    var body: some View {
        HStack {
            if let ImageData = ImageData
            {
                Image(uiImage: UIImage(data: ImageData) ?? UIImage())
                    .resizable()
                    .frame(width: 25, height: 25)
                    .cornerRadius(5)
            }
            else {
                ProgressView()
                    .task {
                        ImageData = await recipe.getSmallImage()
                    }
            }
            Text(recipe.name)
        }
    }
}

#Preview {
    let recipe1 = Recipe(cuisine: "Malaysian",
                             name: "Apam Balik",
                             photo_url_large: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/large.jpg",
                             photo_url_small: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/small.jpg",
                             uuid: "0c6ca6e7-e32a-4053-b824-1dbf749910d8",
                             source_url: "https://www.nyonyacooking.com/recipes/apam-balik~SJ5WuvsDf9WQ",
                             youtube_url: "https://www.youtube.com/watch?v=6R8ffRRJcrg")
    
    RecipeNavigationView(recipe: .constant(recipe1))
}
