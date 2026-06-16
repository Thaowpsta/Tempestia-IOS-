//
//  FavoritesView.swift
//  Tempestia
//
//  Created by Thaowpsta Saiid on 15/06/2026.
//


import SwiftUI
import SwiftData

@available(iOS 17.0, *)
struct FavoritesView: View {
    @Environment(\.tempestia) var theme
    @Environment(\.modelContext) private var modelContext
    @EnvironmentObject var router: AppRouter
    
    @Query(sort: \FavoriteLocation.addedAt, order: .reverse) private var favorites: [FavoriteLocation]
    
    @State private var localSearchText = ""
    @State private var isShowingAddSheet = false
    @State private var showingDeleteAlert = false
    @State private var locationToDelete: FavoriteLocation?
    
    private var filteredFavorites: [FavoriteLocation] {
        if localSearchText.isEmpty { return favorites }
        return favorites.filter { $0.name.localizedCaseInsensitiveContains(localSearchText) }
    }
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottomTrailing) {
                
                AnimatedParticleBackground()
                    .ignoresSafeArea()
                
                VStack(spacing: 0) {
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(theme.text3)
                        TextField("", text: $localSearchText, prompt: Text("Filter favorites...").foregroundColor(theme.text3.opacity(0.8)))
                            .foregroundColor(theme.text1)
                            .tint(theme.purpleBright)
                    }
                    .padding(16)
                    .tempestiaGlass(radius: 20)
                    .padding(.horizontal, 24)
                    .padding(.top, 16)
                    
                    if filteredFavorites.isEmpty {
                        emptyStateView
                            .padding(.top, 60)
                        Spacer()
                    } else {
                        List {
                            ForEach(filteredFavorites) { location in
                                Button(action: {
                                    router.navigateToFavorite(id: location.id)
                                }) {
                                    FavoriteRow(location: location)
                                }
                                .buttonStyle(PlainButtonStyle())
                                .padding(.bottom, 8)
                                .listRowBackground(Color.clear)
                                .listRowSeparator(.hidden)
                            }
                            .onDelete(perform: confirmDelete)
                        }
                        .listStyle(.plain)
                        .scrollContentBackground(.hidden)
                        .padding(.horizontal, 16)
                    }
                }
                
                Button(action: {
                    isShowingAddSheet = true
                }) {
                    Image(systemName: "plus")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(.white)
                        .frame(width: 60, height: 60)
                        .background(
                            Circle()
                                .fill(theme.purpleBright)
                                .shadow(color: theme.purpleBright.opacity(0.5), radius: 10, x: 0, y: 5)
                        )
                }
                .padding(.trailing, 24)
                .padding(.bottom, 120)
            }
            .navigationTitle("Favorites")
            .onAppear {
                let appearance = UINavigationBarAppearance()
                appearance.configureWithTransparentBackground()
                
                appearance.largeTitleTextAttributes = [.foregroundColor: UIColor(theme.text1)]
                appearance.titleTextAttributes = [.foregroundColor: UIColor(theme.text1)]
                
                UINavigationBar.appearance().standardAppearance = appearance
                UINavigationBar.appearance().scrollEdgeAppearance = appearance
            }
            .sheet(isPresented: $isShowingAddSheet) {
                AddCitySheet()
                    .presentationDetents([.medium, .large])
            }
            .alert("Remove City", isPresented: $showingDeleteAlert, presenting: locationToDelete) { location in
                Button("Cancel", role: .cancel) {
                    locationToDelete = nil
                }
                Button("Remove", role: .destructive) {
                    performActualDeletion(location)
                }
            } message: { location in
                Text("Are you sure you want to remove \(location.name) from your favorites?")
            }
        }
    }
    
    private var emptyStateView: some View {
        VStack(spacing: 16) {
            Image(systemName: "heart.slash.fill")
                .font(.system(size: 64))
                .foregroundColor(theme.text3.opacity(0.5))
            
            Text("No Cities Found")
                .font(.title2.bold())
                .foregroundColor(theme.text1)
        }
    }
        
    private func confirmDelete(offsets: IndexSet) {
        if let index = offsets.first {
            locationToDelete = filteredFavorites[index]
            showingDeleteAlert = true
        }
    }
    
    private func performActualDeletion(_ location: FavoriteLocation) {
        withAnimation {
            modelContext.delete(location)
            locationToDelete = nil
        }
    }
}
