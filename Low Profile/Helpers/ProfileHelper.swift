//
//  ProfileHelper.swift
//  Low Profile
//
//  Created by Nindi Gill on 23/5/2023.
//

import Foundation

class ProfileHelper: NSObject {
    static let shared: ProfileHelper = ProfileHelper()

    private let keys: [String] = [
        "_name",
        "_items",
        "spconfigprofile_profile_identifier",
        "spconfigprofile_profile_uuid",
        "spconfigprofile_other_info",
        "spconfigprofile_description",
        "spconfigprofile_organization",
        "spconfigprofile_version",
        "spconfigprofile_RemovalDisallowed",
        "spconfigprofile_install_date",
        "spconfigprofile_certificate_payload_uuid",
        "spconfigprofile_verification_state",
        "spconfigprofile_payload_identifier",
        "spconfigprofile_payload_display_name",
        "spconfigprofile_payload_uuid",
        "spconfigprofile_payload_version",
        "spconfigprofile_payload_data"
    ]

    func getProfiles() -> [Profile] {
        let url: URL = URL(fileURLWithPath: "\(NSTemporaryDirectory())/LowProfile.plist")

        guard FileManager.default.createFile(atPath: url.path, contents: nil) else {
            return []
        }

        do {
            let output: FileHandle = try FileHandle(forWritingTo: url)
            let process: Process = Process()
            process.launchPath = "/usr/bin/env"
            process.arguments = ["system_profiler", "-xml", "SPConfigurationProfileDataType", "-detailLevel", "full"]
            process.standardOutput = output
            process.launch()
            process.waitUntilExit()

            guard process.terminationStatus == 0 else {
                return []
            }

            let data: Data = try Data(contentsOf: url)
            var format: PropertyListSerialization.PropertyListFormat = .xml
            var profiles: [Profile] = []

            guard let array: [[String: Any]] = try PropertyListSerialization.propertyList(from: data, options: [], format: &format) as? [[String: Any]] else {
                return []
            }

            for dictionary in array {
                guard let parentItems: [[String: Any]] = dictionary["_items"] as? [[String: Any]] else {
                    continue
                }

                for parentItem in parentItems {
                    guard let items: [[String: Any]] = parentItem["_items"] as? [[String: Any]] else {
                        continue
                    }

                    profiles.append(contentsOf: items.compactMap { profile(for: $0) })
                }
            }

            return profiles.sorted { $0.name < $1.name }
        } catch {
            print(error.localizedDescription)
            return []
        }
    }

    private func profile(for dictionary: [String: Any]) -> Profile? {
        var dictionary: [String: Any] = dictionary
        dictionary["PayloadType"] = "Configuration"
        dictionary["PayloadDisplayName"] = dictionary["_name"]
        dictionary["PayloadIdentifier"] = dictionary["spconfigprofile_profile_identifier"]
        dictionary["PayloadUUID"] = dictionary["spconfigprofile_profile_uuid"]
        dictionary["PayloadDescription"] = dictionary["spconfigprofile_description"]
        dictionary["PayloadOrganization"] = dictionary["spconfigprofile_organization"]
        dictionary["PayloadVersion"] = dictionary["spconfigprofile_version"]

        guard let array: [[String: Any]] = dictionary["_items"] as? [[String: Any]] else {
            return nil
        }

        var payloadContent: [[String: Any]] = []

        for item in array {
            var payloadDictionary: [String: Any] = item
            payloadDictionary["PayloadType"] = payloadDictionary["_name"]
            payloadDictionary["PayloadDisplayName"] = payloadDictionary["spconfigprofile_payload_display_name"]
            payloadDictionary["PayloadIdentifier"] = payloadDictionary["spconfigprofile_payload_identifier"]
            payloadDictionary["PayloadUUID"] = payloadDictionary["spconfigprofile_payload_uuid"]
            payloadDictionary["PayloadDescription"] = payloadDictionary["spconfigprofile_description"]
            payloadDictionary["PayloadOrganization"] = payloadDictionary["spconfigprofile_organization"]
            payloadDictionary["PayloadVersion"] = payloadDictionary["spconfigprofile_payload_version"]

            if payloadDictionary["spconfigprofile_payload_data"] == nil {
                payloadDictionary["spconfigprofile_payload_data"] = ""
            }

            guard let string: String = payloadDictionary["spconfigprofile_payload_data"] as? String,
                let jsonString: String = string.toJSONString(),
                let data: Data = jsonString.data(using: .utf8) else {
                continue
            }

            do {
                if let dictionary: [String: Any] = try JSONSerialization.jsonObject(with: data, options: [.fragmentsAllowed, .json5Allowed]) as? [String: Any] {
                    payloadDictionary.merge(dictionary) { current, _ in current }
                }
            } catch {
                print(error.localizedDescription)
            }

            keys.forEach { payloadDictionary.removeValue(forKey: $0) }
            payloadContent.append(payloadDictionary)
        }

        dictionary["PayloadContent"] = payloadContent
        keys.forEach { dictionary.removeValue(forKey: $0) }

        do {
            let data: Data = try PropertyListSerialization.data(fromPropertyList: dictionary, format: .xml, options: .bitWidth)
            return Profile(from: data)
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
}
