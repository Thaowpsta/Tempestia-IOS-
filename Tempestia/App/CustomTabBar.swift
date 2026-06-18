//
//  CustomTabBar.swift
//  Tempestia
//
//  Created by Thaowpsta Saiid on 15/06/2026.
//

import SwiftUI

@available(iOS 16.0, *)
struct CustomTabBar: View {
    @Environment(\.tempestia) var theme
    @Binding var selectedTab: AppTab
    
    var body: some View {
        HStack {
            ForEach(AppTab.allCases, id: \.self) { tab in
                Spacer()
                
                Button(action: {
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                        selectedTab = tab
                    }
                }) {
                    VStack(spacing: 4) {
                        Image(systemName: tab.rawValue)
                            .font(.system(size: 22))
                            .foregroundColor(selectedTab == tab ? theme.purpleBright : theme.text3)
                            .scaleEffect(selectedTab == tab ? 1.1 : 1.0)
                        
                        Text(LocalizedStringKey(tab.title))
                            .font(.system(size: 10, weight: selectedTab == tab ? .bold : .medium))
                            .foregroundColor(selectedTab == tab ? theme.purpleBright : theme.text3)
                    }
                }
                
                Spacer()
            }
        }
        .padding(.vertical, 12)
        .background(theme.isMorning ? .white : .black)
        .cornerRadius(40)
        
    }
}
