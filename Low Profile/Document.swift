//
//  Document.swift
//  Low Profile
//
//  Created by Nindi Gill on 2/8/20.
//

import SwiftUI
import UniformTypeIdentifiers

struct Document: FileDocument {

    static var readableContentTypes: [UTType] = [.mobileconfig]
    var profile: Profile = Profile()

    init(configuration: ReadConfiguration) throws {

        guard let data: Data = configuration.file.regularFileContents,
            let object: Profile = Profile(from: data) else {
            throw DocumentError("Unable to load Configuration Profile")
        }

        profile = object
    }

    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        throw DocumentError("Unable to save Configuration Profile")
    }
}
