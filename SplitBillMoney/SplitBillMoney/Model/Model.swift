//
//  Model.swift
//  MoneySplitBill
//
//  Created by Vasyl Petrych on 07/04/2026.
//

import Foundation
import Combine

struct Person: Identifiable, Codable, Equatable {
    let id: UUID
    var name: String
    var isPinned: Bool = false

    init(id: UUID = UUID(), name: String) {
        self.id = id
        self.name = name
    }
}

struct Cost: Identifiable, Codable {
    let id: UUID
    var title: String
    var amount: Double
    var participants: [UUID]
    var isPinned: Bool = false
   

    init(id: UUID = UUID(), title: String, amount: Double, participants: [UUID]) {
        self.id = id
        self.title = title
        self.amount = amount
        self.participants = participants
    }
}

