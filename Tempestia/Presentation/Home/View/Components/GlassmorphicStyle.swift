//
//  GlassmorphicStyle.swift
//  Tempestia
//
//  Created by Thaowpsta Saiid on 13/06/2026.
//

import SwiftUI

struct GlassmorphicStyle: ViewModifier {
    @Environment(\.tempestia) var theme
    let cornerRadius: CGFloat
    
    func body(content: Content) -> some View {
        content
            .background(theme.glass)
            .background(.ultraThinMaterial)
            .cornerRadius(cornerRadius)
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(theme.glassBorder, lineWidth: 1)
            )
    }
}

extension View {
    func tempestiaGlass(radius: CGFloat = 32) -> some View {
        self.modifier(GlassmorphicStyle(cornerRadius: radius))
    }
}
