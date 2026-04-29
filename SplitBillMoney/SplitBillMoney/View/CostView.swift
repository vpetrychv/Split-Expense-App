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
                // MARK: - COSTS
                Section(header: Text("Costs")) {
                    ForEach(viewModel.sortedCosts) { cost in
                        NavigationLink {
                            CostDetailView(cost: cost)
                                .environmentObject(viewModel)
                        } label: {
                            VStack(alignment: .leading, spacing: 4) {
                                
                                HStack {
                                    Text(cost.title)
                                        .font(.headline)
                                    
                                    if cost.isPinned {
                                        Image(systemName: "pin.fill")
                                            .foregroundColor(.yellow)
                                    }
                                }
                                
                                Text("\(cost.amount, specifier: "%.2f") €")
                                    .foregroundColor(.gray)
                                
                                Text(participantText(for: cost))
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                    .lineLimit(2)
                            }
                        }
                        .swipeActions(edge: .leading) {
                            Button {
                                viewModel.pinCost(cost)
                            } label: {
                                Label(cost.isPinned ? "Unpin" : "Pin",
                                      systemImage: "pin")
                            }
                            .tint(.yellow)
                        }
                        .swipeActions(edge: .trailing) {
                            Button(role: .destructive) {
                                viewModel.deleteCost(cost)
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                            .tint(.red)
                        }
                    }
                }
                
                // MARK: - TOTALS
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
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    // MARK: - Helper
    private func participantText(for cost: Cost) -> String {
        let names = cost.participants.compactMap { id in
            viewModel.people.first(where: { $0.id == id })?.name
        }
        
        return "Participants: \(names.count) — \(names.joined(separator: ", "))"
    }
}


#Preview {
    CostView()
        .environmentObject(BillViewModel())
}

