//
//  Api Controller.swift
//  Cookapedia
//
//  Created by Everett Brothers on 1/23/24.
//

import SwiftUI
import CoreData

class ApiController {
    static let shared = ApiController()
    
    private let apiKey = "lbFkcZ9QQYfvkMsXrGAn+Q==oBdpGZMMYXaF0OeS"
    private let url = "https://api.api-ninjas.com/v1/recipe?query="
    
    enum ApiControllerError: Error {
        case searchFailed
    }
    
    func searchRecipies(for query: String, at offset: Int = 0) async throws -> [Recipe] {
        let url = URL(string: url)!
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        components.queryItems = [
            "query": query,
            "offset": "\(10 * offset)"
        ].map { URLQueryItem(name: $0.key, value: $0.value) }
        var request = URLRequest(url: components.url!)
        request.setValue(apiKey, forHTTPHeaderField: "X-Api-Key")
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let http = response as? HTTPURLResponse, http.statusCode == 200 else {
            throw ApiControllerError.searchFailed
        }
        
        let recipies = try JSONDecoder().decode([Recipe].self, from: data)
        return recipies
    }
}
