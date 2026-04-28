//
//  ContentView.swift
//  MoneySplitBill
//
//  Created by Vasyl Petrych on 07/04/2026.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        TabView {
            
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
            
            ParticipantsView()
                .tabItem {
                    Label("People", systemImage: "person.fill")
                }
            
            CostView()
                .tabItem{
                    Label("Bill", systemImage: "book.pages")
                }
        }
        .tint(.blue)
    }
}

#Preview {
    ContentView()
        .environmentObject(BillViewModel())
}
