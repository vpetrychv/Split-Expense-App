//
//  EditCostView.swift
//  MoneySplitBill
//
//  Created by Vasyl Petrych on 20/04/2026.
//

import SwiftUI

struct EditCostView: View {
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: BillViewModel
    
    let cost: Cost
    
    @State private var title: String
    @State private var amount: String
    @State private var selectedPeople: Set<UUID>
    
    init(cost: Cost) {
        self.cost = cost
        _title = State(initialValue: cost.title)
        _amount = State(initialValue: String(cost.amount))
        _selectedPeople = State(initialValue: Set(cost.participants))
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Info") {
                    TextField("Title", text: $title)
                    TextField("Amount", text: $amount)
                        .keyboardType(.decimalPad)
                    
                }
                Section("Participants") {
                    ForEach(viewModel.people) { person in
                        
                        HStack {
                            Text(person.name)
                            
                            Spacer()
                            
                            if selectedPeople.contains(person.id) {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(.green)
                            }
                        }
                        .contentShape(Rectangle())
                        .onTapGesture {
                            toggle(person.id)
                        }
                    }
                }
            }
            .navigationTitle("Edit Expense")
            .toolbar {
                
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        save()
                        dismiss()
                    }
                }
            }
        }
    }
    
    private func toggle(_ id: UUID) {
        if selectedPeople.contains(id) {
            selectedPeople.remove(id)
        } else {
            selectedPeople.insert(id)
        }
    }
    
    private func save() {
        guard let value = Double(amount) else { return }
        
        viewModel.updateCost(
            id: cost.id,
            title: title,
            amount: value,
            participants: Array(selectedPeople)
        )
    }
}

