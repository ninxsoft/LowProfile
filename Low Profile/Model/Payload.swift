//
//  Payload.swift
//  Low Profile
//
//  Created by Nindi Gill on 3/8/20.
//

import Foundation

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
    var example: String
    var platforms: [Platform]
    var availability: Availability
    var payloadVersion: Int
    var payloadIdentifier: String
    var payloadUUID: String
    var payloadDisplayName: String
    var payloadDescription: String
    var payloadOrganisation: String
    var payloadProperties: [Property]
    var managedPayloads: [Payload]
    var availableProperties: [Property]
    var unknownProperties: [Property]
    var dictionary: [String: Any]
    var propertyList: String? {

        do {
            let data: Data = try PropertyListSerialization.data(fromPropertyList: dictionary, format: .xml, options: 0)

            guard let string: String = String(data: data, encoding: .utf8) else {
                return nil
            }

            return string
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    var general: Bool {
        paths.contains("toplevel")
    }
    var custom: Bool {
        paths.isEmpty
    }
    var deprecated: Bool {
        !platforms.filter { $0.deprecated }.isEmpty
    }
    var beta: Bool {
        !platforms.filter { $0.beta }.isEmpty
    }
    var managed: Bool {
        payloadDescription.isEmpty && payloadDisplayName.isEmpty && payloadIdentifier.isEmpty && payloadOrganisation.isEmpty && payloadUUID.isEmpty && payloadVersion == 0
    }

    init() {
        id = UUID().uuidString
        type = ""
        name = ""
        paths = []
        description = ""
        platforms = []
        availability = Availability(dictionary: [:])
        discussion = []
        example = ""
        payloadVersion = 0
        payloadIdentifier = ""
        payloadUUID = ""
        payloadDisplayName = ""
        payloadDescription = ""
        payloadOrganisation = ""
        payloadProperties = []
        managedPayloads = []
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
        example = PayloadHelper.shared.example(for: type)
        payloadProperties = PayloadHelper.shared.payloadProperties(for: type, in: dictionary)
        managedPayloads = PayloadHelper.shared.managedPayloads(for: type, in: dictionary)
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
