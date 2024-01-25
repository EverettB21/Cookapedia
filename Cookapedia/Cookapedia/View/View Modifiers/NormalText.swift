//
//  NormalText.swift
//  Cookapedia
//
//  Created by Everett Brothers on 1/24/24.
//

import SwiftUI

struct NormalText: ViewModifier {
    
    var color: Color
    
    func body(content: Content) -> some View {
        content
            .foregroundStyle(color)
    }
}

extension View {
    func normalText(_ color: Color = .black) -> some View {
        modifier(NormalText(color: color))
    }
}
