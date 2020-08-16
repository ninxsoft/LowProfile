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

  init(fileWrapper: FileWrapper, contentType: UTType) throws {

    guard let data: Data = fileWrapper.regularFileContents,
          let object: Profile = Profile(from: data) else {
      throw DocumentError("Unable to load Configuration Profile")
    }

    profile = object
  }

  func write(to fileWrapper: inout FileWrapper, contentType: UTType) throws {
    // do nothing
  }
}
