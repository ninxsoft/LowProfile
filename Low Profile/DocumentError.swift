//
//  DocumentError.swift
//  Low Profile
//
//  Created by Nindi Gill on 15/8/20.
//

import Foundation

struct DocumentError: Error {
  let message: String

  public var localizedDescription: String {
    return message
  }

  init(_ message: String) {
    self.message = message
  }
}
