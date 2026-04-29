//
//  HomeView.swift
//  MoneySplitBill
//
//  Created by Vasyl Petrych on 10/04/2026.
//

import SwiftUI

struct HomeView: View {
    
    enum Field {
        case amount
        case people
    }
    
    @EnvironmentObject var viewModel: BillViewModel
    @FocusState private var focusedField: Field?
    @State private var showResult = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Text("Split Bill")
                    .font(.largeTitle)
                    .fontWeight(.light)
                
                TextField("Amount", text: $viewModel.amount)
                    .onChange(of: viewModel.amount) { newValue in
                        viewModel.amount = newValue.filter {
                            $0.isNumber || $0 == "." || $0 == ","
                        }
                    }
                    .padding()
                    .background(.regularMaterial)
                    .clipShape(Capsule())
                    .overlay(
                        Capsule()
                            .stroke(.white.opacity(0.25))
                    )
                    .padding(.horizontal)
                
                TextField("Number of people", text: $viewModel.peopleCount)
                    .onChange(of: viewModel.peopleCount) { newValue in
                        viewModel.peopleCount = newValue.filter { $0.isNumber }
                    }
                    .padding()
                    .background(.regularMaterial)
                    .clipShape(Capsule())
                    .overlay(
                        Capsule()
                            .stroke(.white.opacity(0.25))
                    )
                    .padding(.horizontal)
                
                Divider()
                
                Spacer()
                
                if showResult {
                    Text("Per person:")
                        .font(.system(size: 20))
                    Text("\(viewModel.result(), specifier: "%.2f") €")
                        .font(.system(size: 36))
                }
                
                Spacer()
                
                CustomButton {
                    showResult = true
                }
            }
            .padding()
        }
    }
}

#Preview {
    HomeView()
        .environmentObject(BillViewModel())
}

