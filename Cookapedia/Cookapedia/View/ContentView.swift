//
//  ContentView.swift
//  Cookapedia
//
//  Created by Everett Brothers on 1/23/24.
//

import SwiftUI
import CoreData

struct ContentView: View, KeyboardReadable {
    
    @Environment(\.managedObjectContext) var context

    @ObservedObject var vc = ViewController.shared
    
    @State var returnPressed = false
    @State var keyboardIsUp = false
    
    @FetchRequest(sortDescriptors: []) var data: FetchedResults<DataRecipe>

    var body: some View {
        if returnPressed {
            NavigationStack {
                SearchView(action: { self.returnPressed = false })
                    .environment(\.managedObjectContext, context)
            }
        } else {
            NavigationStack {
                ZStack {
                    BackgroundView().ignoresSafeArea()
                    VStack {
                        if !keyboardIsUp {
                            NavigationLink {
                                SavedView()
                                    .environment(\.managedObjectContext, context)
                            } label: {
                                Text("Saved Recipies")
                                    .normalText(.mint)
                            }
                            
                            Spacer()
                        }
                    }
                    .frame(height: 650)
                    .navigationTitle("Cookapedia")
                }
                .onAppear {
                    vc.dataRecipies = data
                }
            }
            .searchable(text: $vc.searchText)
            .onReceive(keyboardPublisher) { isVisible in
                self.keyboardIsUp = isVisible
            }
            .onSubmit(of: .search) {
                returnPressed = true
            }
        }
    }

}

#Preview {
    ContentView()
}
