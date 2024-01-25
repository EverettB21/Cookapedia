//
//  Recipe.swift
//  Cookapedia
//
//  Created by Everett Brothers on 1/23/24.
//

import SwiftUI
import CoreData

struct Recipe: Codable {
    
    static let preview = Recipe(title: "test", ingredients: "test", servings: "4", instructions: "cook on med head and then do something then do another thing then cook it then grub it.")
    
    var title: String
    var ingredients: String
    var servings: String
    var instructions: String
    
    var listedIngredients: [String] {
        return ingredients.components(separatedBy: "|")
    }
    
    var detailedInstructions: [String] {
        return instructions.components(separatedBy: ". ")
    }
    
    init(title: String, ingredients: String, servings: String, instructions: String) {
        self.title = title
        self.ingredients = ingredients
        self.servings = servings
        self.instructions = instructions
    }
    
    init(from data: DataRecipe) {
        if let title = data.title, 
            let ing = data.ingredients,
            let serve = data.servings,
            let ins = data.instructions {
            self.title = title
            self.ingredients = ing
            self.servings = serve
            self.instructions = ins
        } else {
            self.title = "failed to get from data"
            self.ingredients = ""
            self.servings = ""
            self.instructions = ""
        }
    }
    
    init(with data: FetchedResults<DataRecipe>.Element) {
        self.title = data.title ?? "Failed to get from data"
        self.ingredients = data.ingredients ?? ""
        self.servings = data.servings ?? ""
        self.instructions = data.instructions ?? ""
    }
}
