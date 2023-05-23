//
//  DocumentError.swift
//  Low Profile
//
//  Created by Nindi Gill on 15/8/20.
//

struct DocumentError: Error {
    let message: String

    public var localizedDescription: String {
        message
    }

    init(_ message: String) {
        self.message = message
    }
}
