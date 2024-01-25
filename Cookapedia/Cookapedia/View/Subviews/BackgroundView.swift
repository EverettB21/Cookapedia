//
//  BackgroundView.swift
//  Cookapedia
//
//  Created by Everett Brothers on 1/23/24.
//

import SwiftUI

struct BackgroundView: View {
    var body: some View {
        ZStack {
            Rectangle()
                .fill(LinearGradient(colors: [.pink, .purple], startPoint: .bottomTrailing, endPoint: .topLeading))
                .frame(width: 3000, height: 3000)
        }
    }
}

#Preview {
    BackgroundView()
}
