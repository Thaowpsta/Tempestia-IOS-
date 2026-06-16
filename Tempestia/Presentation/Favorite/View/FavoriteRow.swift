//
//  FavoriteRow.swift
//  Tempestia
//
//  Created by Thaowpsta Saiid on 16/06/2026.
//


import SwiftUI

@available(iOS 17.0, *)
struct FavoriteRow: View {
    @Environment(\.tempestia) var theme
    let location: FavoriteLocation
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 6) {
                Text(location.name)
                    .font(.system(size: 22, weight: .bold))
                    .foregroundColor(theme.text1)
                
                HStack(spacing: 4) {
                    Image(systemName: "mappin.and.ellipse")
                    Text("Saved Location")
                }
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(theme.text3)
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(theme.purpleSoft)
        }
        .padding(.vertical, 20)
        .padding(.horizontal, 24)
        .tempestiaGlass(radius: 24)
        .listRowBackground(Color.clear)
        .listRowSeparator(.hidden)
    }
}
