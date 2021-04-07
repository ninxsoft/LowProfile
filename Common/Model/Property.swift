//
//  Property.swift
//  Low Profile
//
//  Created by Nindi Gill on 5/8/20.
//

import Cocoa

struct Property: Identifiable {

    static var example: Property {
        let property: Property = Property()
        return property
    }

    // swiftlint:disable:next identifier_name
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

    init() {
        id = UUID().uuidString
        name = ""
        type = ""
        description = []
        attributes = [:]
        required = false
        defaultValue = ""
        possibleValues = []
        minimum = ""
        maximum = ""
        value = ""
    }

    // payload property
    init(availableProperty: Property, payloadValue: Any) {
        self.init()
        self.name = availableProperty.name
        self.type = availableProperty.type
        self.description = availableProperty.description
        self.attributes = availableProperty.attributes

        if let boolean: Bool = attributes["required"] as? Bool {
            required = boolean
        }

        if let string: String = attributes["default"] as? String {
            defaultValue = string
        }

        if let strings: [String] = attributes["possibleValues"] as? [String] {
            possibleValues = strings
        }

        if let string: String = attributes["minimum"] as? String {
            minimum = string
        }

        if let string: String = attributes["maximum"] as? String {
            maximum = string
        }

        self.value = payloadValue
    }

    // available property
    init(availableDictionary: [String: Any]) {
        self.init()

        if let string: String = availableDictionary["name"] as? String {
            name = string
        }

        if let string: String = availableDictionary["type"] as? String {
            type = string
        }

        if let strings: [String] = availableDictionary["description"] as? [String] {
            description = strings
        }

        if let dictionary: [String: Any] = availableDictionary["attributes"] as? [String: Any] {
            attributes = dictionary
        }

        if let boolean: Bool = attributes["required"] as? Bool {
            required = boolean
        }

        if let string: String = attributes["default"] as? String {
            defaultValue = string
        }

        if let strings: [String] = attributes["possibleValues"] as? [String] {
            possibleValues = strings
        }

        if let string: String = attributes["minimum"] as? String {
            minimum = string
        }

        if let string: String = attributes["maximum"] as? String {
            maximum = string
        }
    }

    // unknown property
    init(unknownName: String, unknownValue: Any) {
        self.init()
        self.name = unknownName
        self.value = unknownValue

        if let _: Bool = unknownValue as? Bool {
            self.type = "boolean"
        } else if let _: Data = unknownValue as? Data {
            self.type = "data"
        } else if let _: Date = unknownValue as? Date {
            self.type = "date"
        } else if let _: Int = unknownValue as? Int {
            self.type = "integer"
        } else if let _: NSNumber = unknownValue as? NSNumber {
            self.type = "number"
        } else if let _: String = unknownValue as? String {
            self.type = "string"
        } else if let _: [String] = unknownValue as? [String] {
            self.type = "[string]"
        } else if let _: [String: Any] = unknownValue as? [String: Any] {
            self.type = "dictionary"
        } else if let _: [[String: Any]] = unknownValue as? [[String: Any]] {
            self.type = "[dictionary]"
        } else {
            self.type = "Unknown type"
        }
    }
}
