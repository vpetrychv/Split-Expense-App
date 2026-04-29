//
//  ParticipantsView.swift
//  MoneySplitBill
//
//  Created by Vasyl Petrych on 10/04/2026.
//

import SwiftUI

struct ParticipantsView: View {
    
    @EnvironmentObject var viewModel: BillViewModel
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 15) {
                HStack {
                    TextField("Person Name", text: $viewModel.personName)
                        .padding(10)
                        .background(.regularMaterial)
                        .clipShape(Capsule())
                        .overlay(
                            Capsule()
                                .stroke(.white.opacity(0.25))
                        )
                        .padding(.horizontal, 3)
                    Button {
                        viewModel.addPerson()
                    } label: {
                        Text("Add")
                            .font(.headline)
                            .frame(maxWidth: 40)
                            .padding(10)
                            .background(.blue.gradient)
                            .foregroundStyle(.white)
                            .clipShape(Capsule())
                    }
                    .padding(.horizontal, 3)
                }
                .padding(.horizontal)
                VStack(spacing: 15) {
                    HStack{
                        TextField("Expense Name", text: $viewModel.costTitle)
                            .padding(10)
                            .background(.regularMaterial)
                            .clipShape(Capsule())
                            .overlay(
                                Capsule()
                                    .stroke(.white.opacity(0.25))
                            )
                            .padding(.horizontal, 3)
                        
                        Button {
                            viewModel.addCost()
                        } label: {
                            Text("Add")
                                .font(.headline)
                                .frame(maxWidth: 40)
                                .padding(10)
                                .background(.blue.gradient)
                                .foregroundStyle(.white)
                                .clipShape(Capsule())
                        }
                        .padding(.horizontal, 3)
                    }
                    TextField("Amount", text: $viewModel.costAmount)
                        .padding(10)
                        .background(.regularMaterial)
                        .clipShape(Capsule())
                        .overlay(
                            Capsule()
                                .stroke(.white.opacity(0.25))
                        )
                        .padding(.horizontal, 3)
                    Section(header: Text("Person")) {
                        List {
                            ForEach(viewModel.sortedPeople) { person in
                                HStack {
                                    Text(person.name)
                                    
                                    Spacer()
                                    
                                    if viewModel.selectedPeople.contains(person.id) {
                                        Image(systemName: "checkmark.circle.fill")
                                            .foregroundColor(.green)
                                    }
                                    
                                    if person.isPinned {
                                        Image(systemName: "pin.fill")
                                            .foregroundColor(.yellow)
                                    }
                                }
                                .contentShape(Rectangle())
                                .onTapGesture {
                                    viewModel.togglePersonSelection(person)
                                }
                                .swipeActions(edge: .leading) {
                                    Button {
                                        viewModel.pinPerson(person)
                                    } label: {
                                        Label(person.isPinned ? "Unpin" : "Pin",
                                              systemImage: "pin")
                                    }
                                    .tint(.yellow)
                                }
                                
                                .swipeActions(edge: .trailing) {
                                    Button(role: .destructive) {
                                        viewModel.deletePerson(person)
                                    } label: {
                                        Label("Delete", systemImage: "trash")
                                    }
                                    .tint(.red)
                                }
                            }
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }                }
                .padding(.horizontal)
                
            }
            .navigationTitle("Split Bill")
        }
    }
}

#Preview {
    let vm = BillViewModel()
    
    let p1 = Person(name: "Alex")
    let p2 = Person(name: "John")
    let p3 = Person(name: "Kate")
    
    vm.people = [p1, p2, p3]
    
    vm.costs = [
        Cost(
            title: "Dinner",
            amount: 60,
            participants: [p1.id, p2.id]
        ),
        Cost(
            title: "Taxi",
            amount: 30,
            participants: [p1.id, p2.id, p3.id]
        )
    ]
    
    return ParticipantsView()
        .environmentObject(vm)
}

