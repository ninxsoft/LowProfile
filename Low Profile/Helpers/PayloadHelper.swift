//
//  PayloadHelper.swift
//  Low Profile
//
//  Created by Nindi Gill on 3/8/20.
//

import Foundation
import Yams

class PayloadHelper: NSObject {
    static let shared: PayloadHelper = PayloadHelper()
    private var dictionaries: [String: Any] = [:]
    private var keysToIgnore: [String] {
        [
            "PayloadContent",
            "PayloadDescription",
            "PayloadDisplayName",
            "PayloadEnabled",
            "PayloadIdentifier",
            "PayloadOrganization",
            "PayloadRemovalDisallowed",
            "PayloadType",
            "PayloadUUID",
            "PayloadVersion"
        ]
    }

    override init() {
        let urls: [URL?] = [URL(string: .payloadsURL), Bundle.main.url(forResource: "Payloads", withExtension: "yaml")]

        for url in urls {
            guard let url: URL = url else {
                continue
            }

            do {
                let string: String = try String(contentsOf: url)

                guard let dictionaries: [String: Any] = try Yams.load(yaml: string) as? [String: Any] else {
                    continue
                }

                self.dictionaries = dictionaries
                return
            } catch {
                print(error.localizedDescription)
            }
        }
    }

    func name(for type: String) -> String {
        guard let dictionary: [String: Any] = dictionaries[type] as? [String: Any],
            let string: String = dictionary["name"] as? String else {
            return "Custom"
        }

        return string
    }

    func paths(for type: String) -> [String] {
        guard let dictionary: [String: Any] = dictionaries[type] as? [String: Any],
            let strings: [String] = dictionary["paths"] as? [String] else {
            return []
        }

        return strings
    }

    func description(for type: String) -> String {
        guard let dictionary: [String: Any] = dictionaries[type] as? [String: Any],
            let string: String = dictionary["description"] as? String else {
            return "This is a custom 3rd-party payload."
        }

        return string
    }

    func platforms(for type: String) -> [Platform] {
        guard let dictionary: [String: Any] = dictionaries[type] as? [String: Any],
            let array: [[String: Any]] = dictionary["platforms"] as? [[String: Any]] else {
            return []
        }

        return array.map { Platform(dictionary: $0) }
    }

    func availability(for type: String) -> Availability {
        guard let dictionary: [String: Any] = dictionaries[type] as? [String: Any],
            let availabilityDictionary: [String: Any] = dictionary["availability"] as? [String: Any] else {
            return Availability(dictionary: [:])
        }

        return Availability(dictionary: availabilityDictionary)
    }

    func discussion(for type: String) -> [String] {
        guard let dictionary: [String: Any] = dictionaries[type] as? [String: Any],
            let strings: [String] = dictionary["discussion"] as? [String] else {
            return []
        }

        return strings
    }

    func example(for type: String) -> String {
        guard let dictionary: [String: Any] = dictionaries[type] as? [String: Any],
            let string: String = dictionary["example"] as? String else {
            return ""
        }

        return string
    }

    func transformedDictionary(for type: String, using dictionary: [String: Any]) -> [String: Any] {
        var dictionary: [String: Any] = dictionary
        let knownProperties: [Property] = knownProperties(for: type)

        for (key, value) in dictionary where knownProperties.map(\.name).contains(key) && !keysToIgnore.contains(key) {
            guard let property: Property = knownProperties.first(where: { $0.name == key }) else {
                continue
            }

            switch property.type {
            case "boolean":
                if (property.value as? Bool) != nil {
                    continue
                }

                if let integer: Int = value as? Int {
                    dictionary[key] = Bool(integer == 1)
                }
            case "integer":
                if (property.value as? Int) != nil {
                    continue
                }

                if let boolean: Bool = value as? Bool {
                    dictionary[key] = boolean ? 1 : 0
                }
            default:
                continue
            }
        }

        return dictionary
    }

    func payloadProperties(for type: String, in dictionary: [String: Any]) -> [Property] {
        let availableProperties: [Property] = knownProperties(for: type)
        var properties: [Property] = []

        for key in dictionary.keys.filter({ !keysToIgnore.contains($0) }).sorted() {
            for availableProperty in availableProperties where key == availableProperty.name {
                if let value: Any = dictionary[key] {
                    let property: Property = Property(availableProperty: availableProperty, payloadValue: value)
                    properties.append(property)
                }
            }
        }

        return properties
    }

    func managedPayloads(for type: String, in dictionary: [String: Any]) -> [Payload] {
        guard type == "com.apple.ManagedClient.preferences",
            let payloadContent: [String: Any] = dictionary["PayloadContent"] as? [String: Any] else {
            return []
        }

        var managedPayloads: [Payload] = []

        for type in payloadContent.keys {
            guard let payload: [String: Any] = payloadContent[type] as? [String: Any],
                let array: [[String: Any]] = payload["Forced"] as? [[String: Any]] else {
                continue
            }

            for item in array {
                guard var dictionary: [String: Any] = item["mcx_preference_settings"] as? [String: Any] else {
                    continue
                }

                dictionary["PayloadType"] = type

                let managedPayload: Payload = Payload(dictionary: dictionary)
                managedPayloads.append(managedPayload)
            }
        }

        return managedPayloads
    }

    func availableProperties(for type: String, in dictionary: [String: Any]) -> [Property] {
        let availableProperties: [Property] = knownProperties(for: type)
        return availableProperties.filter { !dictionary.keys.contains($0.name) }
    }

    func unknownProperties(for type: String, in dictionary: [String: Any]) -> [Property] {
        let availableProperties: [Property] = knownProperties(for: type)
        var properties: [Property] = []

        for key in dictionary.keys.filter({ !keysToIgnore.contains($0) }).sorted() {
            if !availableProperties.map(\.name).contains(key),
                let value: Any = dictionary[key] {
                let property: Property = Property(unknownName: key, unknownValue: value)
                properties.append(property)
            }
        }

        return properties
    }

    private func knownProperties(for type: String) -> [Property] {
        guard let dictionary: [String: Any] = dictionaries[type] as? [String: Any],
            let propertyDictionaries: [[String: Any]] = dictionary["properties"] as? [[String: Any]] else {
            return []
        }

        var properties: [Property] = propertyDictionaries.map { Property(availableDictionary: $0) }

        if type == "com.apple.ManagedClient.preferences" {
            properties = properties.filter { $0.name != "PreferenceDomain" }
        }

        return properties
    }

    func string(for value: Any) -> String {
        if let boolean: Bool = value as? Bool {
            return boolean ? "True" : "False"
        }

        if let data: Data = value as? Data {
            return data.base64EncodedString(options: [.lineLength64Characters, .endLineWithCarriageReturn])
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
            let string: String = strings.joined(separator: "\n")
            return string.description
        }

        if let data: Data = try? JSONSerialization.data(withJSONObject: value, options: [.prettyPrinted, .sortedKeys]),
            let string: String = String(data: data, encoding: .utf8) {
            return string
        }

        return "Unknown value type"
    }
}
