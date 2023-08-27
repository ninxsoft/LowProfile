//
//  PropertySection.swift
//  Low Profile
//
//  Created by Nindi Gill on 27/6/2023.
//

enum PropertySection: String, CaseIterable, Identifiable {
    case payload = "Payload"
    case available = "Available"
    case unknown = "Unknown"

    var id: String {
        rawValue
    }
}
