//
//  Property.swift
//  Low Profile
//
//  Created by Nindi Gill on 5/8/20.
//

import Cocoa

struct Property: Identifiable {

    static var example: Property {
        let property: Property = Property(availableDictionary: [:])
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
    var value: Any
    var valueString: String {

        if let boolean: Bool = value as? Bool {
            return boolean ? "True" : "False"
        }

        if let data: Data = value as? Data {
            return "Data: \(data.description)"
        }

        if let date: Date = value as? Date {
            let dateFormatter: DateFormatter = DateFormatter()
            dateFormatter.dateStyle = .full
            dateFormatter.timeStyle = .long
            return dateFormatter.string(from: date)
        }

        if let number: NSNumber = value as? NSNumber {
            return number.stringValue
        }

        if let string: String = value as? String {
            return string
        }

        if let strings: [String] = value as? [String] {
            let string: String = strings.joined(separator: ", ")
            return string.description
        }

        if let data: Data = try? JSONSerialization.data(withJSONObject: value, options: [.prettyPrinted, .sortedKeys]),
            let string: String = String(data: data, encoding: .utf8) {
            return string
        }

        return "Unknown type"
    }
    var descriptionString: String {
        description.joined(separator: "\n\n")
    }

    // payload property
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
        value = payloadValue
    }

    // available property
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
        value = ""
    }

    // unknown property
    init(unknownName: String, unknownValue: Any) {
        id = UUID().uuidString
        name = unknownName

        if let _: Bool = unknownValue as? Bool {
            type = "boolean"
        } else if let _: Data = unknownValue as? Data {
            type = "data"
        } else if let _: Date = unknownValue as? Date {
            type = "date"
        } else if let _: Int = unknownValue as? Int {
            type = "integer"
        } else if let _: NSNumber = unknownValue as? NSNumber {
            type = "number"
        } else if let _: String = unknownValue as? String {
            type = "string"
        } else if let _: [String] = unknownValue as? [String] {
            type = "[string]"
        } else if let _: [String: Any] = unknownValue as? [String: Any] {
            type = "dictionary"
        } else if let _: [[String: Any]] = unknownValue as? [[String: Any]] {
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
        value = unknownValue
    }
}
