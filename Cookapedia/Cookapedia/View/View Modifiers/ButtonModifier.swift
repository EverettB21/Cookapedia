//
//  ButtonModifier.swift
//  Cookapedia
//
//  Created by Everett Brothers on 1/24/24.
//

import SwiftUI

struct ButtonModifier: ViewModifier {
    
    var bgColor: Color
    var fgColor: Color
    var frame: CGFloat
    
    func body(content: Content) -> some View {
        content
            .padding()
            .frame(width: frame)
            .foregroundStyle(fgColor)
            .background(
                RoundedRectangle(cornerRadius: 15)
                    .fill(bgColor)
            )
    }
}

extension View {
    func defaultButton(with bg: Color = .mint, and fg: Color = .black, frame: CGFloat = 250) -> some View {
        modifier(ButtonModifier(bgColor: bg, fgColor: fg, frame: frame))
    }
}
