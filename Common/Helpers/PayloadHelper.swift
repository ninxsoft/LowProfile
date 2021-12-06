//
//  PayloadHelper.swift
//  Low Profile
//
//  Created by Nindi Gill on 3/8/20.
//

import Cocoa
import Yams

class PayloadHelper: NSObject {

    static let shared: PayloadHelper = PayloadHelper()
    private var dictionaries: [String: Any] = [:]
    private var keysToIgnore: [String] {
        [
            "PayloadDescription",
            "PayloadDisplayName",
            "PayloadEnabled",
            "PayloadIdentifier",
            "PayloadOrganization",
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

    func payloadTypes() -> [String] {
        dictionaries.keys.sorted()
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

    func availableProperties(for type: String, in dictionary: [String: Any]) -> [Property] {
        let availableProperties: [Property] = knownProperties(for: type)
        return availableProperties.filter { !dictionary.keys.contains($0.name) }
    }

    func unknownProperties(for type: String, in dictionary: [String: Any]) -> [Property] {

        let availableProperties: [Property] = knownProperties(for: type)
        var properties: [Property] = []

        for key in dictionary.keys.filter({ !keysToIgnore.contains($0) }).sorted() {

            if !availableProperties.map({ $0.name }).contains(key),
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

        return propertyDictionaries.map { Property(availableDictionary: $0) }
    }
}
