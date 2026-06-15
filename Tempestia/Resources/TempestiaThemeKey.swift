//
//  TempestiaThemeKey.swift
//  Tempestia
//
//  Created by Thaowpsta Saiid on 15/06/2026.
//

import SwiftUI

private struct TempestiaThemeKey: EnvironmentKey {
    static let defaultValue: TempestiaTheme = TempestiaTheme(isMorning: true)
}

extension EnvironmentValues {
    var tempestia: TempestiaTheme {
        get { self[TempestiaThemeKey.self] }
        set { self[TempestiaThemeKey.self] = newValue }
    }
}
