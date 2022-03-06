//
//  Availability.swift
//  Low Profile
//
//  Created by Nindi Gill on 6/8/20.
//

import Foundation

/// Availability struct
struct Availability {

    /// Example Availability
    static var example: Availability {
        let availability: Availability = Availability(dictionary: [:])
        return availability
    }

    /// Device channel
    var device: String
    /// User Channel
    var user: String
    /// Allow Manual Install
    var manual: String
    /// Requires Supervision
    var supervision: String
    /// Requires User Approved MDM
    var userApproved: String
    /// Allowed in User Enrollment
    var userEnrol: String
    /// Allow Multiple Payloads
    var multiple: String

    /// Initializer accepting a profile availability dictionary
    init(dictionary: [String: Any]) {
        device = dictionary["device"] as? String ?? ""
        user = dictionary["user"] as? String ?? ""
        manual = dictionary["manual"] as? String ?? ""
        supervision = dictionary["supervision"] as? String ?? ""
        userApproved = dictionary["user_approved"] as? String ?? ""
        userEnrol = dictionary["user_enrol"] as? String ?? ""
        multiple = dictionary["multiple"] as? String ?? ""
    }
}
