//
//  SearchView.swift
//  Cookapedia
//
//  Created by Everett Brothers on 1/24/24.
//

import SwiftUI

struct SearchView: View {
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.managedObjectContext) var context
    
    @ObservedObject var vc = ViewController.shared
    @State var apiError = false
    @State var pageNumber = 0 {
        didSet {
            vc.searchForRecipies(pageNumber) { comp in
                if !comp {
                    self.apiError = true
                }
            }
        }
    }
    var action: () -> ()
    
    var body: some View {
        List {
            if let recipies = vc.recipies {
                Section {
                    ForEach(recipies, id: \.instructions) { recipe in
                        NavigationLink {
                            RecipeDetail(recipe: recipe)
                                .environment(\.managedObjectContext, context)
                        } label: {
                            RecipeListView(recipe: recipe)
                                .frame(width: 300)
                        }
                    }
                    .listRowBackground(Color.clear)
                } header: {
                    Text("Recipies")
                        .font(.title)
                }
            }
        }
        .frame(height: 800)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    action()
                } label: {
                    Text("Cancel")
                        .normalText(.mint)
                }
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    if pageNumber != 0 {
                        pageNumber -= 1
                    }
                } label: {
                    Text("<")
                        .foregroundStyle(.mint)
                }
            }
            ToolbarItem(placement: .topBarTrailing) {
                Text("\(pageNumber + 1)")
                    .normalText(.mint)
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    pageNumber += 1
                } label: {
                    Text(">")
                        .foregroundStyle(.mint)
                }
            }
        }
        .scrollDisabled(false)
        .scrollContentBackground(.hidden)
        .background(BackgroundView())
        .onAppear {
            vc.searchForRecipies { comp in
                if !comp {
                    self.apiError = true
                }
            }
        }
        .alert("Error getting Recipies", isPresented: $apiError) {
            Button("Go Back", role: .cancel) {
                dismiss()
            }
        }
        BannerView(adID: Units.list, adWidth: 450)
            .frame(height: 50)
    }
}

#Preview {
    SearchView(action: { })
}
