//
//  RoundedBorder.swift
//  Cookapedia
//
//  Created by Everett Brothers on 1/24/24.
//

import SwiftUI

struct RoundedBorder: ViewModifier {
    
    var color: Color
    var bgBackground: Color
    var gradient: LinearGradient?
    
    func body(content: Content) -> some View {
        content
            .background(gradient != nil ? gradient : LinearGradient(colors: [bgBackground], startPoint: .topTrailing, endPoint: .bottomLeading))
            .cornerRadius(20)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(color, lineWidth: 5)
            )
    }
}

extension View {
    func borderRounded(with color: Color = .black, and bg: Color = .white, gradient: LinearGradient? = nil) -> some View {
        modifier(RoundedBorder(color: color, bgBackground: bg, gradient: gradient))
    }
}
