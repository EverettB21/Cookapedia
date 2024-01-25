//
//  RecipeDetail.swift
//  Cookapedia
//
//  Created by Everett Brothers on 1/24/24.
//

import SwiftUI

struct RecipeDetail: View {
    
    @Environment(\.managedObjectContext) var context
    
    @ObservedObject var vc = ViewController.shared
    
    @State var recipe: Recipe
    @State var save: Bool = true
    
    let p = PersistenceController.shared
    
    var body: some View {
        ZStack {
            BackgroundView().ignoresSafeArea()
            VStack {
                HStack(alignment: .center) {
                    Text("\(recipe.title.capitalized)")
                        .font(.title)
                    Button {
                        if save {
                            addRecipe(recipe)
                        } else {
                            delete(recipe)
                        }
                        save.toggle()
                    } label: {
                        Image(systemName: save ? "square.and.arrow.down" : "trash")
                            .foregroundStyle(.mint)
                    }
                }
                .frame(width: 360)
                Rectangle().frame(width: 350, height: 5)
                Text("Servings: \(recipe.servings)")
                Text("Steps: \(recipe.detailedInstructions.count)")
                HStack {
                    List {
                        Section {
                            ForEach(recipe.listedIngredients, id: \.self) { ingredient in
                                Text(ingredient)
                            }
                            .listRowBackground(LinearGradient(colors: [Color(uiColor: .magenta), .pink], startPoint: .topLeading, endPoint: .bottomTrailing))
                        } header: {
                            Text("Ingredients")
                        }
                    }
                    .listRowSpacing(10)
                    .scrollContentBackground(.hidden)
                    .frame(width: 170, height: 400)
                    ScrollView {
                        Text(recipe.instructions)
                    }
                    .frame(width: 170, height: 400)
                }
                
                NavigationLink {
                    CookView(recipe: recipe)
                } label: {
                    Text("Start Cooking")
                        .defaultButton()
                }
                
                BannerView(adID: Units.detail, adWidth: 480)
                    .frame(height: 50)
                    .offset(x: -20)
            }
            .frame(width: 390, height: 800, alignment: .center)
        }
        .onAppear {
            if let recipies = vc.savedRecipies {
                if recipies.contains(where: { $0.instructions == recipe.instructions }) {
                    save = false
                }
            }
        }
    }
    
    func addRecipe(_ recipe: Recipe) {
        let dataRecipe = recipe.toData(context)
        if vc.savedRecipies != nil {
            vc.savedRecipies?.append(recipe)
        } else {
            vc.savedRecipies = [recipe]
        }
        context.insert(dataRecipe)
        PersistenceController.shared.save()
    }
    
    func delete(_ recipe: Recipe) {
        let data = vc.dataRecipies?.first(where: { $0.instructions == recipe.instructions })
        vc.savedRecipies?.removeAll(where: { $0.instructions == recipe.instructions })
        if let data = data {
            context.delete(data)
            PersistenceController.shared.save()
        }
    }
}

#Preview {
    RecipeDetail(recipe: Recipe.preview)
}
