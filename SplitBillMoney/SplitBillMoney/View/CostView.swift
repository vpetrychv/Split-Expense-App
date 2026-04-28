//
//  CostView.swift
//  MoneySplitBill
//
//  Created by Vasyl Petrych on 17/04/2026.
//

import SwiftUI

struct CostView: View {
    
    @EnvironmentObject var viewModel: BillViewModel
    
    var totals: [UUID: Double] {
        viewModel.totalPerPerson()
    }
    
    var body: some View {
        NavigationStack {
            
            List {
                
                // MARK: - Costs section
                Section(header: Text("Select participants")) {
                    ForEach(viewModel.costs) { cost in
                        
                        NavigationLink {
                            CostDetailView(cost: cost)
                                .environmentObject(viewModel)
                        } label: {
                            VStack(alignment: .leading, spacing: 4) {
                                
                                Text(cost.title)
                                    .font(.headline)
                                
                                Text("\(cost.amount, specifier: "%.2f") €")
                                    .foregroundColor(.gray)
                                
                                Text("Participants: \(cost.participants.count)")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                    .onDelete(perform: viewModel.deleteCost)
                }
                
                // MARK: - Totals section
                Section(header: Text("Total per person")) {
                    ForEach(viewModel.people) { person in
                        HStack {
                            Text(person.name)
                            
                            Spacer()
                            
                            Text("\(totals[person.id] ?? 0, specifier: "%.2f") €")
                                .fontWeight(.bold)
                        }
                    }
                }
            }
            .navigationTitle("Check")
            .navigationBarTitleDisplayMode(.inline) // 👈 фікс руху
//            .toolbar {
//                ToolbarItemGroup(placement: .keyboard) {
//                    Spacer()
//                    Button("Done") {
//                        viewModel.hideKeyboard()
//                    }
//                }
//            }

        }
    }
}

#Preview {
    CostView()
        .environmentObject(BillViewModel())
}

