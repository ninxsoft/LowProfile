//
//  IssueType.swift
//  Low Profile
//
//  Created by Nindi Gill on 2/9/2023.
//

import Foundation

enum IssueType: String, Identifiable, CaseIterable {
    // swiftlint:disable:next redundant_string_enum_value
    case deprecated = "deprecated"
    // swiftlint:disable:next redundant_string_enum_value
    case duplicated = "duplicated"

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
