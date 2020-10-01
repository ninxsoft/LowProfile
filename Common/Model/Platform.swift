//
//  Platform.swift
//  Low Profile
//
//  Created by Nindi Gill on 6/8/20.
//

import SwiftUI

struct Platform: Identifiable {

    static var example: Platform {
        let platform: Platform = Platform()
        return platform
    }

    // swiftlint:disable:next identifier_name
    var id: String
    var name: String
    var introducedAt: String
    var current: String
    var deprecated: Bool
    var deprecatedAt: String
    var beta: Bool
    var description: String {
        let string: String = "\(name) \(introducedAt) - \(deprecated ? deprecatedAt : current)"
        return string
    }

    init() {
        id = UUID().uuidString
        name = ""
        introducedAt = ""
        current = ""
        deprecated = false
        deprecatedAt = ""
        beta = false
    }

    init(dictionary: [String: Any]) {
        self.init()

        if let string: String = dictionary["name"] as? String {
            name = string
        }

        if let string: String = dictionary["introduced_at"] as? String {
            introducedAt = string
        }

        if let string: String = dictionary["current"] as? String {
            current = string
        }

        if let boolean: Bool = dictionary["deprecated"] as? Bool {
            deprecated = boolean
        }

        if let string: String = dictionary["deprecated_at"] as? String {
            deprecatedAt = string
        }

        if let boolean: Bool = dictionary["beta"] as? Bool {
            beta = boolean
        }
    }
}
