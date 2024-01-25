//
//  RecipeListView.swift
//  Cookapedia
//
//  Created by Everett Brothers on 1/24/24.
//

import SwiftUI

struct RecipeListView: View {
    
    @State var recipe: Recipe
    
    var body: some View {
        VStack {
            VStack {
                Text("\(recipe.title.capitalized)")
                    .font(.title)
                    .normalText(.white)
                Text("Servings: \(recipe.servings)")
                    .normalText(.white)
                Text("Steps: \(recipe.detailedInstructions.count)")
                    .normalText(.white)
            }
            
            Spacer().frame(height: 20)
            
            Text("\(recipe.instructions)")
                .normalText(.white)
                .frame(maxHeight: 100)
        }
        .padding()
        .frame(width: 300, height: 250)
        .borderRounded(gradient: LinearGradient(colors: [.red, .pink], startPoint: .bottomTrailing, endPoint: .topLeading))
    }
}

#Preview {
    RecipeListView(recipe: Recipe.preview)
}
