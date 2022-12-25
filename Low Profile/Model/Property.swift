//
//  Property.swift
//  Low Profile
//
//  Created by Nindi Gill on 5/8/20.
//

import ASN1Decoder
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

        if unknownValue as? Bool != nil {
            type = "boolean"
        } else if unknownValue as? Data != nil {
            type = "data"
        } else if unknownValue as? Date != nil {
            type = "date"
        } else if unknownValue as? Int != nil {
            type = "integer"
        } else if unknownValue as? NSNumber != nil {
            type = "number"
        } else if unknownValue as? String != nil {
            type = "string"
        } else if unknownValue as? [String] != nil {
            type = "[string]"
        } else if unknownValue as? [String: Any] != nil {
            type = "dictionary"
        } else if unknownValue as? [[String: Any]] != nil {
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
