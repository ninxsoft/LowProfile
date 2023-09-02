//
//  IssueType.swift
//  Low Profile
//
//  Created by Nindi Gill on 2/9/2023.
//

import Foundation

enum IssueType: String {
    // swiftlint:disable:next redundant_string_enum_value
    case deprecated = "deprecated"
    // swiftlint:disable:next redundant_string_enum_value
    case duplicated = "duplicated"

    var description: String {
        rawValue
    }
}
