//
//  Profile.swift
//  Low Profile
//
//  Created by Nindi Gill on 3/8/20.
//

import ASN1Decoder
import Foundation

/// Configuration Profile struct
struct Profile: Identifiable, Hashable {

    /// Example Profile
    static var example: Profile {
        let profile: Profile = Profile()
        return profile
    }

    /// Unique configuration profile identifier
    var id: String
    /// Configuration profile display name
    var name: String
    /// Array of configuration profile payload objects
    var payloads: [Payload]
    /// Optional certificates used to sign the configuration profile
    var certificates: [X509Certificate]

    /// Default initializer
    init() {
        id = ""
        name = ""
        payloads = []
        certificates = []
    }

    /// Initializer accepting (an optionally signed) data blob
    ///
    /// - Parameters:
    ///   - signedData: The (optionally signed) data blob.
    init?(from signedData: Data) {
        self.init()

        var data: Data = signedData

        do {
            let pkcs7: PKCS7 = try PKCS7(data: data)

            if let unsignedData: Data = pkcs7.data {
                data = unsignedData
            }

            certificates = pkcs7.certificates.sorted {
                guard let subject: String = $0.subjectDistinguishedName,
                    let issuer: String = $1.issuerDistinguishedName else {
                    return false
                }

                return !subject.contains(issuer)
            }
        } catch {
            // print(error.localizedDescription)
        }

        do {
            guard let dictionary: [String: Any] = try PropertyListSerialization.propertyList(from: data, options: [], format: nil) as? [String: Any] else {
                return nil
            }

            self.payloads = []

            // MARK: Testing
            // self.payloads = PayloadHelper.shared.payloadTypes().map { Payload(dictionary: ["PayloadType": $0]) }.sorted { $0.name < $1.name }
            // return

            var topLevelDictionary: [String: Any] = dictionary
            topLevelDictionary.removeValue(forKey: "PayloadContent")

            if let id: String = topLevelDictionary["PayloadIdentifier"] as? String {
                self.id = id
            }

            if let name: String = topLevelDictionary["PayloadDisplayName"] as? String {
                self.name = name
            }

            let payload: Payload = Payload(dictionary: topLevelDictionary)
            self.payloads.append(payload)

            if let array: [[String: Any]] = dictionary["PayloadContent"] as? [[String: Any]] {
                for item in array {
                    let payload: Payload = Payload(dictionary: item)
                    self.payloads.append(payload)
                }
            }

            return
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }

    static func == (lhs: Profile, rhs: Profile) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
