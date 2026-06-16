//
//  AddCitySheet.swift
//  Tempestia
//
//  Created by Thaowpsta Saiid on 16/06/2026.
//


import SwiftUI
import SwiftData

@available(iOS 17.0, *)
struct AddCitySheet: View {
    @Environment(\.tempestia) var theme
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    @StateObject private var viewModel = DependencyInjector.resolve(LocationSearchViewModel.self)
    
    var body: some View {
        VStack(spacing: 16) {
          
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(theme.text3)
                TextField("Search for a city...", text: $viewModel.searchText)
                    .foregroundColor(theme.text1)
                    .onChange(of: viewModel.searchText) { _, _ in
                        viewModel.performSearch()
                    }
            }
            .padding(16)
            .background(theme.glassBorder.opacity(0.5))
            .cornerRadius(16)
            .padding(.horizontal)
            .padding(.top, 20)
            
            if viewModel.isSearching {
                ProgressView().padding(.top, 20)
                Spacer()
            } else {
                ScrollView {
                    VStack(spacing: 0) {
                        ForEach(viewModel.searchResults) { result in
                            Button(action: {
                                saveLocation(result)
                            }) {
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(result.name)
                                        .font(.system(size: 18, weight: .bold))
                                        .foregroundColor(theme.text1)
                                    Text("\(result.region), \(result.country)")
                                        .font(.system(size: 14))
                                        .foregroundColor(theme.text3)
                                }
                                .contentShape(Rectangle())
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.vertical, 12)
                                .padding(.horizontal, 20)
                            }
                            .buttonStyle(PlainButtonStyle())
                            
                            Divider().background(theme.glassBorder.opacity(0.3))
                        }
                    }
                }
            }
        }
        .presentationBackground(theme.bgCard)
        .presentationCornerRadius(32)
    }
    
    private func saveLocation(_ result: LocationSearchResult) {
        let newFavorite = FavoriteLocation(
            name: result.name,
            latitude: result.latitude,
            longitude: result.longitude
        )
        
        modelContext.insert(newFavorite)
        
        do {
            try modelContext.save()
        } catch {
            print("Failed to save location: \(error.localizedDescription)")
        }
        
        dismiss()
    }
}
