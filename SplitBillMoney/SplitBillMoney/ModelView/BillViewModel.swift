//
//  BillViewModel.swift
//  MoneySplitBill
//
//  Created by Vasyl Petrych on 07/04/2026.
//

import Foundation
import SwiftUI
import Combine

final class BillViewModel: ObservableObject {
    
    @Published var amount: String = ""
    @Published var peopleCount: String = ""
    @Published var people: [Person] = []
    @Published var personName: String = ""
    @Published var costs: [Cost] = []
    @Published var costTitle: String = ""
    @Published var costAmount: String = ""
    @Published var selectedPeople: Set<UUID> = []
    
    private let peopleKey = "people"
    private let costsKey = "costs"
    
    init() {
        loadData()
    }
    
    func saveData() {
        if let encodedPeople = try? JSONEncoder().encode(people) {
            UserDefaults.standard.set(encodedPeople, forKey: peopleKey)
        }
        if let encodedCosts = try? JSONEncoder().encode(costs) {
            UserDefaults.standard.set(encodedCosts, forKey: costsKey)
        }
    }
    
    func loadData() {
        if let data = UserDefaults.standard.data(forKey: peopleKey),
           let decodedPeople = try? JSONDecoder().decode([Person].self, from: data) {
            self.people = decodedPeople
        }
        if let data = UserDefaults.standard.data(forKey: costsKey),
           let decodedCosts = try? JSONDecoder().decode([Cost].self, from: data) {
            self.costs = decodedCosts
        }
    }

    func addPerson() {
        let trimmed = personName.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }
        people.append(Person(name: trimmed))
        personName = ""
        saveData()
    }

    func deletePerson(at offsets: IndexSet) {
        people.remove(atOffsets: offsets)
        saveData()
    }

    func togglePersonSelection(_ person: Person) {
        if selectedPeople.contains(person.id) {
            selectedPeople.remove(person.id)
        } else {
            selectedPeople.insert(person.id)
        }
    }

    func addCost() {
        let title = costTitle.trimmingCharacters(in: .whitespacesAndNewlines)
        let amountValue = Double(costAmount.replacingOccurrences(of: ",", with: ".")) ?? 0
        guard !title.isEmpty,
              amountValue > 0,
              !selectedPeople.isEmpty else { return }
        let newCost = Cost(
            title: title,
            amount: amountValue,
            participants: Array(selectedPeople)
        )
        costs.append(newCost)
        costTitle = ""
        costAmount = ""
        selectedPeople.removeAll()
        saveData()
    }

    func updateCost(id: UUID, title: String, amount: Double, participants: [UUID]) {
        if let index = costs.firstIndex(where: { $0.id == id }) {
            costs[index].title = title
            costs[index].amount = amount
            costs[index].participants = participants
            saveData()
        }
    }

    func deleteCost(at offsets: IndexSet) {
        costs.remove(atOffsets: offsets)
        saveData()
    }

    func totalPerPerson() -> [UUID: Double] {
        var result: [UUID: Double] = [:]
        for cost in costs {
            let share = cost.amount / Double(cost.participants.count)
            for personID in cost.participants {
                result[personID, default: 0] += share
            }
        }
        return result
    }

    func result() -> Double {
        let total = Double(amount.replacingOccurrences(of: ",", with: ".")) ?? 0
        let count = Int(peopleCount) ?? 0
        guard count > 0 else { return 0 }
        return total / Double(count)
    }

//    func hideKeyboard() {
//        UIApplication.shared.sendAction(
//            #selector(UIResponder.resignFirstResponder),
//            to: nil,
//            from: nil,
//            for: nil
//        )
//    }
}
    


