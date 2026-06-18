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
    
    private let repository: WeatherRepositoryProtocol
    private var searchTask: Task<Void, Never>?
    
    init(repository: WeatherRepositoryProtocol) {
        self.repository = repository
    }
    
    func performSearch() {
        searchTask?.cancel()
        
        guard searchText.count > 2 else {
            searchResults = []
            return
        }
        
        searchTask = Task {
            isSearching = true
            do {
                let results = try await repository.searchLocations(query: searchText)
                
                if !Task.isCancelled {
                    self.searchResults = results
                    self.isSearching = false
                }
            } catch {
                print("Search failed: \(error)")
                self.isSearching = false
            }
        }
    }
}
