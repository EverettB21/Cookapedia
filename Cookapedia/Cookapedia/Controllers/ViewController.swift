//
//  ViewController.swift
//  Cookapedia
//
//  Created by Everett Brothers on 1/23/24.
//

import SwiftUI
import CoreData

@MainActor
class ViewController: ObservableObject {
    static let shared = ViewController()
    
    let apiController = ApiController.shared
    
    typealias CompletionHandler = (Bool) -> Void
    
    @Published var recipies: [Recipe]?
    @Published var savedRecipies: [Recipe]?
    @Published var dataRecipies: FetchedResults<DataRecipe>?
    @Published var searchText = ""
    
    func searchForRecipies(_ pgn: Int = 0, completion: @escaping CompletionHandler) {
        self.recipies?.removeAll()
        Task {
            do {
                self.recipies = try await apiController.searchRecipies(for: self.searchText, at: pgn)
                if self.recipies != nil {
                    completion(true)
                }
            } catch {
                print("Error: \(error.localizedDescription)")
                completion(false)
            }
        }
    }
}
