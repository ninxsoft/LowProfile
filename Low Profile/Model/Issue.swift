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
            type: .deprecated,
            propertyName: Property.example.name,
            profiles: [.example],
            payloads: [.example]
        )
    }

    var id: String
    var type: IssueType
    var propertyName: String
    var profiles: [Profile] = []
    var payloads: [Payload] = []

    static func == (lhs: Issue, rhs: Issue) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
