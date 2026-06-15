//
//  SettingsView.swift
//  Tempestia
//
//  Created by Thaowpsta Saiid on 15/06/2026.
//

import SwiftUI

@available(iOS 16.0, *)
struct SettingsView: View {
    @Environment(\.tempestia) var theme
    var body: some View {
        NavigationView {
            VStack {
                Text("Settings").font(.largeTitle).foregroundColor(theme.text1)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.clear)
        }
    }
}
