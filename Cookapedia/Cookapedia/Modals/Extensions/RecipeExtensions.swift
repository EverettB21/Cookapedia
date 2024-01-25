//
//  RecipeExtensions.swift
//  Cookapedia
//
//  Created by Everett Brothers on 1/23/24.
//

import SwiftUI
import CoreData

extension Recipe {
    func toData(_ context: NSManagedObjectContext) -> DataRecipe {
        let data = DataRecipe(context: context)
        data.title = self.title
        data.ingredients = self.ingredients
        data.servings = self.servings
        data.instructions = self.instructions
        return data
    }
}

extension [Recipe] {
    func toData(_ context: NSManagedObjectContext) -> [DataRecipe] {
        var data = [DataRecipe]()
        for r in self {
            data.append(r.toData(context))
        }
        return data
    }
}
