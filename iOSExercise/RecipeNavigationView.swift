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
            VStack {
                Text(recipe.name)
            }
        }
    }
}

#Preview {
    
    RecipeNavigationView(recipe: .constant(recipe1))
}
