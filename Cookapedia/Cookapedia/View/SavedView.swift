//
//  SavedView.swift
//  Cookapedia
//
//  Created by Everett Brothers on 1/25/24.
//

import SwiftUI

struct SavedView: View {
    
    @Environment(\.managedObjectContext) var context
    
    @ObservedObject var vc = ViewController.shared
    
    @FetchRequest(sortDescriptors: []) var data: FetchedResults<DataRecipe>
    
    let p = PersistenceController.shared
    
    var body: some View {
        List {
            if let recipies = vc.savedRecipies {
                Section {
                    ForEach(recipies, id: \.instructions) { recipe in
                        NavigationLink {
                            RecipeDetail(recipe: recipe)
                        } label: {
                            RecipeListView(recipe: recipe)
                                .frame(width: 300)
                        }
                    }
                    .onDelete { offsets in
                        delete(at: offsets)
                    }
                    .listRowBackground(Color.clear)
                } header: {
                    Text("Saved Recipies")
                        .font(.title)
                }
            }
        }
        .scrollContentBackground(.hidden)
        .background(BackgroundView())
        .onAppear {
            vc.dataRecipies = data
            if let recipies = vc.dataRecipies {
                vc.savedRecipies = recipies.map { Recipe(with: $0) }
            }
        }
    }
    
    func delete(at offsets: IndexSet) {
        for i in offsets {
            let recipie = vc.savedRecipies?[i]
            if let recipie = recipie {
                let r = vc.dataRecipies?.first(where: { $0.instructions == recipie.instructions })
                if let r = r {
                    vc.savedRecipies?.remove(at: i)
                    context.delete(r)
                    PersistenceController.shared.save()
                }
            }
        }
    }
}

#Preview {
    SavedView()
}
