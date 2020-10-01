//
//  Availability.swift
//  Low Profile
//
//  Created by Nindi Gill on 6/8/20.
//

import Foundation

struct Availability {

    static var example: Availability {
        let availability: Availability = Availability()
        return availability
    }

    var device: String
    var user: String
    var manual: String
    var supervision: String
    var userApproved: String
    var userEnrol: String
    var multiple: String

    init() {
        device = ""
        user = ""
        manual = ""
        supervision = ""
        userApproved = ""
        userEnrol = ""
        multiple = ""
    }

    init(dictionary: [String: Any]) {
        self.init()

        if let string: String = dictionary["device"] as? String {
            device = string
        }

        if let string: String = dictionary["user"] as? String {
            user = string
        }

        if let string: String = dictionary["manual"] as? String {
            manual = string
        }

        if let string: String = dictionary["supervision"] as? String {
            supervision = string
        }

        if let string: String = dictionary["user_approved"] as? String {
            userApproved = string
        }

        if let string: String = dictionary["user_enrol"] as? String {
            userEnrol = string
        }

        if let string: String = dictionary["multiple"] as? String {
            multiple = string
        }
    }
}
