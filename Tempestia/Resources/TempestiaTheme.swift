//
//  TempestiaTheme.swift
//  Tempestia
//
//  Created by Thaowpsta Saiid on 13/06/2026.
//

import SwiftUI

struct TempestiaTheme {
    let isMorning: Bool

    // MARK: - Background
    var bgDeep: Color { isMorning ? Color(hex: 0xF0ECE8) : Color(hex: 0x0D0A1A) }
    var bgSurface: Color { isMorning ? Color(hex: 0xDDD5F0) : Color(hex: 0x231848) }
    var bgCard: Color { isMorning ? Color(hex: 0xFFFFFF).opacity(0.85) : Color(hex: 0x1D113C).opacity(0.85) }

    // MARK: - Text
    var text1: Color { isMorning ? Color(hex: 0x1E1040) : Color(hex: 0xF3F0FF) }
    var text2: Color { isMorning ? Color(hex: 0x4C1D95) : Color(hex: 0xE9D5FF) }
    var text3: Color { isMorning ? Color(hex: 0x6D5A9E) : Color(hex: 0x8B7EC8) }

    // MARK: - Purple
    var purpleCore: Color { Color(hex: 0x7C3AED) }
    var purpleBright: Color { isMorning ? Color(hex: 0x9333EA) : Color(hex: 0xA855F7) }
    var purpleSoft: Color { isMorning ? Color(hex: 0x7C3AED) : Color(hex: 0xC4B5FD) }

    // MARK: - Accent
    var goldLight: Color { isMorning ? Color(hex: 0xF59E0B) : Color(hex: 0xFCD34D) }

    // MARK: - Glass
    var glass: Color { Color(hex: 0x7C3AED).opacity(isMorning ? 0.06 : 0.08) }
    var glassBorder: Color { (isMorning ? Color(hex: 0x7C3AED) : Color(hex: 0xA855F7)).opacity(isMorning ? 0.18 : 0.22) }

    // MARK: - Gradients
    var tempGradient: LinearGradient {
        LinearGradient(colors: [text1, purpleBright], startPoint: .topLeading, endPoint: .bottomTrailing)
    }
}

// MARK: - Hex Color Helper
extension Color {
    init(hex: UInt32) {
        let r = Double((hex >> 16) & 0xFF) / 255
        let g = Double((hex >> 8) & 0xFF) / 255
        let b = Double(hex & 0xFF) / 255
        self.init(red: r, green: g, blue: b)
    }
}
