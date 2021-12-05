//
//  Payload.swift
//  Low Profile
//
//  Created by Nindi Gill on 3/8/20.
//

import Cocoa

struct Payload: Identifiable, Hashable {

    static var example: Payload {
        var payload: Payload = Payload()
        payload.type = "Configuration"
        payload.name = "General"
        return payload
    }

    var id: String
    var type: String
    var name: String
    var paths: [String]
    var description: String
    var discussion: [String]
    var platforms: [Platform]
    var availability: Availability
    var payloadVersion: Int
    var payloadIdentifier: String
    var payloadUUID: String
    var payloadDisplayName: String
    var payloadDescription: String
    var payloadOrganisation: String
    var payloadProperties: [Property]
    var availableProperties: [Property]
    var unknownProperties: [Property]
    var dictionary: [String: Any]
    var propertyListString: String {

        var propertyListString: String = ""

        do {
            let data: Data = try PropertyListSerialization.data(fromPropertyList: dictionary, format: .xml, options: 0)

            if let string: String = String(data: data, encoding: .utf8) {
                propertyListString = string
            }
        } catch {
            print(error.localizedDescription)
        }

        return propertyListString
    }
    var general: Bool {
        paths.contains("toplevel")
    }
    var managedPreferences: Bool {
        paths.contains("com.apple.ManagedClient.preferences")
    }
    var custom: Bool {
        paths.isEmpty
    }
    var completeDiscussion: String {
        discussion.joined(separator: "\n\n")
    }
    var image: NSImage {
        PayloadHelper.shared.image(for: name)
    }
    var deprecated: Bool {

        for platform in platforms where platform.deprecated {
            return true
        }

        return false
    }
    var beta: Bool {

        for platform in platforms where platform.beta {
            return true
        }

        return false
    }

    init() {
        id = UUID().uuidString
        type = ""
        name = ""
        paths = []
        description = ""
        platforms = []
        availability = Availability()
        discussion = []
        payloadVersion = 0
        payloadIdentifier = ""
        payloadUUID = ""
        payloadDisplayName = ""
        payloadDescription = ""
        payloadOrganisation = ""
        payloadProperties = []
        availableProperties = []
        unknownProperties = []
        dictionary = [:]
    }

    init(dictionary: [String: Any]) {
        self.init()

        for key in dictionary.keys {

            if key == "PayloadType", let string: String = dictionary[key] as? String {
                type = string
            }

            if key == "PayloadVersion", let integer: Int = dictionary[key] as? Int {
                payloadVersion = integer
            }

            if key == "PayloadIdentifier", let string: String = dictionary[key] as? String {
                payloadIdentifier = string
            }

            if key == "PayloadUUID", let string: String = dictionary[key] as? String {
                payloadUUID = string
            }

            if key == "PayloadDisplayName", let string: String = dictionary[key] as? String {
                payloadDisplayName = string
            }

            if key == "PayloadDescription", let string: String = dictionary[key] as? String {
                payloadDescription = string
            }

            if key == "PayloadOrganization", let string: String = dictionary[key] as? String {
                payloadOrganisation = string
            }
        }

        name = PayloadHelper.shared.name(for: type)
        paths = PayloadHelper.shared.paths(for: type)
        description = PayloadHelper.shared.description(for: type)
        platforms = PayloadHelper.shared.platforms(for: type)
        availability = PayloadHelper.shared.availability(for: type)
        discussion = PayloadHelper.shared.discussion(for: type)
        payloadProperties = PayloadHelper.shared.payloadProperties(for: type, in: dictionary)
        availableProperties = PayloadHelper.shared.availableProperties(for: type, in: dictionary)
        unknownProperties = PayloadHelper.shared.unknownProperties(for: type, in: dictionary)
        self.dictionary = dictionary
    }

    static func == (lhs: Payload, rhs: Payload) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
