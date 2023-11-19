//
//  IssueType.swift
//  Low Profile
//
//  Created by Nindi Gill on 2/9/2023.
//

import Foundation

enum IssueType: String, Identifiable, CaseIterable {
    case deprecated
    case duplicated

    var id: String {
        rawValue
    }

    var description: String {
        rawValue
    }

    var pluralDescription: String {
        rawValue.replacingOccurrences(of: "ed", with: "ions")
    }
}
