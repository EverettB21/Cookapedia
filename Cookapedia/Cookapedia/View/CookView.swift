//
//  CookView.swift
//  Cookapedia
//
//  Created by Everett Brothers on 1/24/24.
//

import SwiftUI

struct CookView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @State var recipe: Recipe
    @State var instructionIndex = 0
    @State var stepsRemaining = 0
    
    @State var textOpacity = 1.0
    
    var body: some View {
        ZStack {
            BackgroundView().ignoresSafeArea()
            VStack {
                if instructionIndex < recipe.detailedInstructions.count {
                    Text(recipe.title.capitalized)
                        .font(.title)
                    Rectangle().frame(width: 350, height: 5)
                    Text("Servings: \(recipe.servings)")
                    Text("Steps Remaining: \(stepsRemaining)")
                    
                    ScrollView {
                        Text(recipe.detailedInstructions[instructionIndex])
                            .font(.largeTitle)
                            .opacity(textOpacity)
                    }.frame(width: 300, height: 400)
                    
                    HStack {
                        Button {
                            animateTextFade {
                                instructionIndex -= 1
                                stepsRemaining += 1
                            }
                        } label: {
                            if instructionIndex != 0 {
                                Text("< Back")
                                    .defaultButton(frame: 100)
                            }
                        }
                        
                        Button {
                            animateTextFade {
                                instructionIndex += 1
                                stepsRemaining -= 1
                            }
                        } label: {
                            Text("Next >")
                                .defaultButton(frame: 100)
                        }
                    }
                } else {
                    Button {
                        dismiss()
                    } label: {
                        Text("Done")
                            .defaultButton()
                    }
                }
            }
            .onAppear {
                stepsRemaining = recipe.detailedInstructions.count - 1
            }
        }
    }
    
    private func animateTextFade(completion: @escaping () -> Void) {
            withAnimation {
                textOpacity = 0
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                completion()
                withAnimation {
                    textOpacity = 1
                }
            }
        }
}

#Preview {
    CookView(recipe: Recipe.preview)
}
