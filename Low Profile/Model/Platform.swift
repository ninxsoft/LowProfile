//
//  Platform.swift
//  Low Profile
//
//  Created by Nindi Gill on 6/8/20.
//

import SwiftUI

struct Platform: Identifiable {
    static var example: Platform {
        let platform: Platform = Platform(dictionary: [:])
        return platform
    }

    var id: String
    var name: String
    var introducedAt: String
    var current: String
    var deprecated: Bool
    var deprecatedAt: String
    var beta: Bool
    var supportedVersions: String {
        "\(introducedAt) - \(deprecated ? deprecatedAt : current)"
    }

    init(dictionary: [String: Any]) {
        id = UUID().uuidString
        name = dictionary["name"] as? String ?? ""
        introducedAt = dictionary["introduced_at"] as? String ?? ""
        current = dictionary["current"] as? String ?? ""
        deprecated = dictionary["deprecated"] as? Bool ?? false
        deprecatedAt = dictionary["deprecated_at"] as? String ?? ""
        beta = dictionary["beta"] as? Bool ?? false
    }
}
