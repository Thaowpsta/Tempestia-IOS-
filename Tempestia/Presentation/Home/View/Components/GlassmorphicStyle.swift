//
//  GlassmorphicStyle.swift
//  Tempestia
//
//  Created by Thaowpsta Saiid on 13/06/2026.
//

import SwiftUI

struct GlassmorphicStyle: ViewModifier {
    let theme: TempestiaTheme
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
    func tempestiaGlass(theme: TempestiaTheme, radius: CGFloat = 32) -> some View {
        self.modifier(GlassmorphicStyle(theme: theme, cornerRadius: radius))
    }
}
