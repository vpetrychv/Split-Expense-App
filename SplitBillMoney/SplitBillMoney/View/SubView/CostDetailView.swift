//
//  CostDetailView.swift
//  MoneySplitBill
//
//  Created by Vasyl Petrych on 20/04/2026.
//
import SwiftUI

struct CostDetailView: View {
    
    let cost: Cost
    
    @EnvironmentObject var viewModel: BillViewModel
    @State private var showEdit = false
    
    var participants: [Person] {
        let ids = Set(cost.participants)
        return viewModel.people.filter { ids.contains($0.id) }
    }
    
    var body: some View {
        List {
            Section("Info") {
                HStack {
                    Text("Title Expense")
                    Spacer()
                    Text(cost.title)
                        .foregroundColor(.secondary)
                }
                HStack{
                    Text("Amount")
                    Spacer()
                    Text("\(cost.amount, specifier: "%.2f") €")
                }
                
            }
            Section("Participants") {
                ForEach(participants) { person in
                    HStack {
                        Image(systemName: "person.circle.fill")
                            .foregroundColor(.blue)
                        
                        Text(person.name)
                    }
                }
            }
        }
        .navigationTitle("Details")
        .toolbar {
            Button("Edit") {
                showEdit = true
            }
        }
        .sheet(isPresented: $showEdit) {
            EditCostView(cost: cost)
                .environmentObject(viewModel)
        }
    }
}

#Preview {
    let vm = BillViewModel()
    
    let p1 = Person(name: "Anna")
    let p2 = Person(name: "John")
    
    vm.people = [p1, p2]
    
    let cost = Cost(
        title: "Dinner",
        amount: 30,
        participants: [p1.id, p2.id]
    )
    
    return NavigationStack {
        CostDetailView(cost: cost)
            .environmentObject(vm)
    }
}



