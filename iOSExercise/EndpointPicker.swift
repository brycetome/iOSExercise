//
//  EndpointPicker.swift
//  iOSExercise
//
//  Created by Bryce Tome on 4/13/25.
//

import SwiftUI

struct EndpointPicker: View {
    @Binding var selectedEndpoint: RecipeEndpoint
    
    var body: some View {
        Menu(content: {
            Picker(selection: $selectedEndpoint, label: Image(selectedEndpoint.imageName)) {
                ForEach(RecipeEndpoint.allCases, id: \.rawValue) { item in
                    Label(item.rawValue, systemImage: item.imageName).tag(item)
                }
            }
        }, label: { Label("Endpoint", systemImage: selectedEndpoint.imageName)})
    }
}

#Preview {
    EndpointPicker(selectedEndpoint: .constant(.All))
}
