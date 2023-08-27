//
//  DetailTab.swift
//  Low Profile
//
//  Created by Nindi Gill on 26/6/2023.
//

enum DetailTab: String {
    case information = "Information"
    case discussion = "Discussion"
    case certificates = "Certificates"
    case payloadProperties = "Payload Properties"
    case availableProperties = "Available Properties"
    case unknownProperties = "Unknown Properties"
    case propertyList = "Property List"

    var description: String {
        rawValue
    }
}
