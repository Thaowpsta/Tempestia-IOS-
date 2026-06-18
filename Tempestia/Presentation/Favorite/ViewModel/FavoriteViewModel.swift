//
//  FavoriteViewModel.swift
//  Tempestia
//
//  Created by Thaowpsta Saiid on 16/06/2026.
//


import Foundation
import Combine

@MainActor
class FavoriteViewModel: ObservableObject {
    @Published var searchText = ""
    @Published var searchResults: [LocationSearchResult] = []
    @Published var isSearching = false
    @Published var errorMessage: String?
    
    private let repository: WeatherRepositoryProtocol
    private var searchTask: Task<Void, Never>?
    
    init(repository: WeatherRepositoryProtocol) {
        self.repository = repository
    }
    
    func performSearch(query: String? = nil) {
        let textToSearch = query ?? searchText
        
        guard NetworkMonitor.shared.isConnected else {
            self.errorMessage = "No internet connection."
            self.searchResults = []
            self.isSearching = false
            return
        }
        
        guard textToSearch.count >= 3 else {
            searchResults = []
            return
        }
        
        isSearching = true
        errorMessage = nil
        
        Task {
            do {
                self.searchResults = try await repository.searchLocations(query: textToSearch)
                self.isSearching = false
            } catch {
                self.errorMessage = "Search failed: \(error.localizedDescription)"
                self.isSearching = false
            }
        }
    }
}
