//
//  PayloadProperties.swift
//  Low Profile
//
//  Created by Nindi Gill on 9/8/20.
//

import SwiftUI

struct PayloadProperties_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      ForEach(PayloadProperties.PropertyType.allCases) { type in
        PayloadProperties(type: type, properties: [.example], spacing: 10)
      }
    }
  }
}

struct PayloadProperties: View {

  enum PropertyType: String, Identifiable, CaseIterable {
    case payload
    case available
    case unknown

    // swiftlint:disable:next identifier_name
    var id: String {
      return self.rawValue
    }

    var description: String {
      switch self {
      case .payload:
        return "The following properties are in the profile payload, and are supported:"
      case .available:
        return "The following properties are not in the profile payload, and are supported:"
      case .unknown:
        return "The following properties are in the profile payload, and are unknown:"
      }
    }
  }

  var type: PropertyType
  var properties: [Property]
  var spacing: CGFloat

  var body: some View {
    VStack(spacing: spacing) {
      Text(type.description)
        .font(.title3)
        .foregroundColor(.secondary)
        .padding(.bottom)
      ScrollView(.vertical) {
        ForEach(properties) { property in
          PayloadProperty(property: property, type: type)
        }
      }
    }
    .padding()
  }
}
