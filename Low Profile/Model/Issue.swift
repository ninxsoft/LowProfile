//
//  Issue.swift
//  Low Profile
//
//  Created by Nindi Gill on 23/5/2023.
//

import Foundation

struct Issue: Identifiable, Hashable {

    static var example: Issue {
        Issue(
            id: UUID().uuidString,
            profiles: [.example],
            payloads: [.example],
            duplicatedProperty: Property.example.name,
            deprecatedProperty: Property.example.name
        )
    }

    var id: String
    var profiles: [Profile] = []
    var payloads: [Payload] = []
    var duplicatedProperty: String?
    var deprecatedProperty: String?

    static func == (lhs: Issue, rhs: Issue) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
