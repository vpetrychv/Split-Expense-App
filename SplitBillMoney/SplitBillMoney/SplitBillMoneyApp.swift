//
//  SplitBillMoneyApp.swift
//  SplitBillMoney
//
//  Created by Vasyl Petrych on 28/04/2026.
//

import SwiftUI

@main
struct SplitBillMoneyApp: App {
    
    @AppStorage("isLightMode") private var isLightMode = true
    @StateObject private var viewModel = BillViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
                .preferredColorScheme(isLightMode ? .light : .dark)
        }
    }
}
