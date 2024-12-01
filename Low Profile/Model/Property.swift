//
//  Property.swift
//  Low Profile
//
//  Created by Nindi Gill on 5/8/20.
//

import Foundation

struct Property: Identifiable, Hashable {
    static var example: Property {
        let property: Property = .init(availableDictionary: [:])
        return property
    }

    var id: String
    var name: String
    var type: String
    var description: [String]
    var attributes: [String: Any]
    var required: Bool
    var defaultValue: String
    var possibleValues: [String]
    var minimum: String
    var maximum: String
    var deprecated: Bool
    var value: Any
    var descriptionString: String {
        description.joined(separator: "\n\n")
    }

    init(
        id: String,
        name: String,
        type: String,
        description: [String],
        attributes: [String: Any],
        required: Bool,
        defaultValue: String,
        possibleValues: [String],
        minimum: String,
        maximum: String,
        deprecated: Bool,
        value: Any
    ) {
        self.id = id
        self.name = name
        self.type = type
        self.description = description
        self.attributes = attributes
        self.required = required
        self.defaultValue = defaultValue
        self.possibleValues = possibleValues
        self.minimum = minimum
        self.maximum = maximum
        self.deprecated = deprecated
        self.value = value
    }

    init(availableProperty: Property, payloadValue: Any) {
        id = UUID().uuidString
        name = availableProperty.name
        type = availableProperty.type
        description = availableProperty.description
        attributes = availableProperty.attributes
        required = attributes["required"] as? Bool ?? false
        defaultValue = attributes["default"] as? String ?? ""
        possibleValues = attributes["possibleValues"] as? [String] ?? []
        minimum = attributes["minimum"] as? String ?? ""
        maximum = attributes["maximum"] as? String ?? ""
        deprecated = attributes["deprecated"] as? Bool ?? false
        value = payloadValue
    }

    init(availableDictionary: [String: Any]) {
        id = UUID().uuidString
        name = availableDictionary["name"] as? String ?? ""
        type = availableDictionary["type"] as? String ?? ""
        description = availableDictionary["description"] as? [String] ?? []
        attributes = availableDictionary["attributes"] as? [String: Any] ?? [:]
        required = attributes["required"] as? Bool ?? false
        defaultValue = attributes["default"] as? String ?? ""
        possibleValues = attributes["possibleValues"] as? [String] ?? []
        minimum = attributes["minimum"] as? String ?? ""
        maximum = attributes["maximum"] as? String ?? ""
        deprecated = attributes["deprecated"] as? Bool ?? false
        value = ""
    }

    init(unknownName: String, unknownValue: Any) {
        id = UUID().uuidString
        name = unknownName

        if unknownValue is Bool {
            type = "boolean"
        } else if unknownValue is Data {
            type = "data"
        } else if unknownValue is Date {
            type = "date"
        } else if unknownValue is Int {
            type = "integer"
        } else if unknownValue is NSNumber {
            type = "number"
        } else if unknownValue is String {
            type = "string"
        } else if unknownValue is [String] {
            type = "[string]"
        } else if unknownValue is [String: Any] {
            type = "dictionary"
        } else if unknownValue is [[String: Any]] {
            type = "[dictionary]"
        } else {
            type = "Unknown type"
        }

        description = []
        attributes = [:]
        required = false
        defaultValue = ""
        possibleValues = []
        minimum = ""
        maximum = ""
        deprecated = false
        value = unknownValue
    }

    static func == (lhs: Property, rhs: Property) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
}
