//
//  UTType+Extension.swift
//  Low Profile
//
//  Created by Nindi Gill on 2/8/20.
//

import UniformTypeIdentifiers

extension UTType {
    /// Low Profile Report Uniform Type.
    static var lowprofilereport: UTType = .init(importedAs: "com.ninxsoft.lowprofile.report")
    /// Configuration Profile (.mobileconfig) Uniform Type.
    static var mobileconfig: UTType = .init(importedAs: "com.apple.mobileconfig")
}
