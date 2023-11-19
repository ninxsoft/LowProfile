//
//  ReportDocument.swift
//  Low Profile
//
//  Created by Nindi Gill on 29/8/2023.
//

import SwiftUI
import UniformTypeIdentifiers

struct ReportDocument: FileDocument {
    static var readableContentTypes: [UTType] = [.lowprofilereport]
    var profiles: [Profile] = []

    init(configuration: ReadConfiguration) throws {
        guard let data: Data = configuration.file.regularFileContents,
            let array: [[String: Any]] = try PropertyListSerialization.propertyList(from: data, options: [], format: nil) as? [[String: Any]] else {
            throw DocumentError("Unable to load Report")
        }

        for item in array {
            guard let id: String = item["id"] as? String,
                let name: String = item["name"] as? String,
                let payloads: [[String: Any]] = item["payloads"] as? [[String: Any]] else {
                throw DocumentError("Unable to load Report")
            }

            let profile: Profile = .init(id: id, name: name, payloads: payloads)
            profiles.append(profile)
        }
    }

    func fileWrapper(configuration _: WriteConfiguration) throws -> FileWrapper {
        throw DocumentError("Unable to save Report")
    }
}
