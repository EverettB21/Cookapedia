//
//  DataRecipeExtensions.swift
//  Cookapedia
//
//  Created by Everett Brothers on 1/23/24.
//

import Foundation

extension [DataRecipe] {
    func toRecipe() -> [Recipe] {
        var recipies = [Recipe]()
        for r in self {
            recipies.append(Recipe(from: r))
        }
        return recipies
    }
}
