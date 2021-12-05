//
//  PayloadHelper.swift
//  Low Profile
//
//  Created by Nindi Gill on 3/8/20.
//

import Cocoa

class PayloadHelper: NSObject {

    static let shared: PayloadHelper = PayloadHelper()
    private var dictionaries: [String: Any] = [:]
    private var keysToIgnore: [String] {
        [
            "PayloadType",
            "PayloadVersion",
            "PayloadIdentifier",
            "PayloadUUID",
            "PayloadDisplayName",
            "PayloadDescription",
            "PayloadOrganization",
            "PayloadEnabled"
        ]
    }

    override init() {

        let directoryURL: URL = URL(fileURLWithPath: NSHomeDirectory() + "/Library/Application Support/Low Profile", isDirectory: true)
        let payloadsURL: URL = directoryURL.appendingPathComponent("Payloads.plist")

        if let url: URL = URL(string: .payloadsURL) {

            do {
                let plist: String = try String(contentsOf: url)

                if !FileManager.default.fileExists(atPath: directoryURL.path) {
                    try FileManager.default.createDirectory(at: directoryURL, withIntermediateDirectories: true, attributes: nil)
                }

                try plist.write(to: payloadsURL, atomically: true, encoding: .utf8)
            } catch {
                print(error.localizedDescription)
            }
        }

        guard let bundlePayloadsURL: URL = Bundle.main.url(forResource: "Payloads", withExtension: "plist") else {
            return
        }

        let url: URL = FileManager.default.fileExists(atPath: payloadsURL.path) ? payloadsURL : bundlePayloadsURL

        do {
            let data: Data = try Data(contentsOf: url)

            guard let dictionaries = try PropertyListSerialization.propertyList(from: data, options: .mutableContainersAndLeaves, format: nil) as? [String: Any] else {
                return
            }

            self.dictionaries = dictionaries
        } catch {
            print(error.localizedDescription)
        }
    }

    func payloadTypes() -> [String] {

        var types: [String] = []

        for key in dictionaries.keys.sorted() {
            types.append(key)
        }

        return types
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

        var platforms: [Platform] = []

        for item in array {
            let platform: Platform = Platform(dictionary: item)
            platforms.append(platform)
        }

        return platforms
    }

    func availability(for type: String) -> Availability {

        guard let dictionary: [String: Any] = dictionaries[type] as? [String: Any],
            let availabilityDictionary: [String: Any] = dictionary["availability"] as? [String: Any] else {
            return Availability()
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

    func image(for type: String) -> NSImage {

        if let image: NSImage = NSImage(named: type) {
            return image
        }

        if let image: NSImage = NSImage(named: "Custom") {
            return image
        }

        return NSApplication.shared.applicationIconImage
    }

    func payloadProperties(for type: String, in dictionary: [String: Any]) -> [Property] {

        let availableProperties: [Property] = knownProperties(for: type)
        var properties: [Property] = []

        for key in dictionary.keys.sorted() {

            guard !keysToIgnore.contains(key) else {
                continue
            }

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
        var properties: [Property] = []

        for availableProperty in availableProperties where !dictionary.keys.contains(availableProperty.name) {
            properties.append(availableProperty)
        }

        return properties
    }

    func unknownProperties(for type: String, in dictionary: [String: Any]) -> [Property] {

        let availableProperties: [Property] = knownProperties(for: type)
        var properties: [Property] = []

        for key in dictionary.keys.sorted() {

            guard !keysToIgnore.contains(key) else {
                continue
            }

            if !availableProperties.map({ $0.name }).contains(key),
                let value: Any = dictionary[key] {
                let property: Property = Property(unknownName: key, unknownValue: value)
                properties.append(property)
            }
        }

        return properties
    }

    private func knownProperties(for type: String) -> [Property] {

        var properties: [Property] = []

        if let dictionary: [String: Any] = dictionaries[type] as? [String: Any],
            let propertyDictionaries: [[String: Any]] = dictionary["properties"] as? [[String: Any]] {

            for propertyDictionary in propertyDictionaries {
                let property: Property = Property(availableDictionary: propertyDictionary)
                properties.append(property)
            }
        }

        return properties
    }
}
