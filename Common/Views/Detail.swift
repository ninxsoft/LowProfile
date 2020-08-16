//
//  Detail.swift
//  Low Profile
//
//  Created by Nindi Gill on 3/8/20.
//

import SwiftUI
import ASN1Decoder

struct Detail_Previews: PreviewProvider {
  static var previews: some View {
    Detail(payload: .example, certificate: nil)
  }
}

struct Detail: View {
  var payload: Payload
  var certificate: X509Certificate?
  private let spacing: CGFloat = 10
  private let padding: CGFloat = 10
  private let height: CGFloat = 225

  var body: some View {
    VStack {
      DetailHeading(payload: payload)
      VStack(spacing: spacing) {
        TabView {
          DetailInformation(payload: payload, spacing: spacing)
            .tabItem {
              Text("Information")
            }
          if !payload.general && !payload.custom {
            DetailAvailability(availability: payload.availability, spacing: spacing)
              .tabItem {
                Text("Availability")
              }
          }
          if !payload.custom {
            DetailDiscussion(discussion: payload.completeDiscussion)
              .tabItem {
                Text("Discussion")
              }
          }
          if payload.general && certificate != nil {
            DetailCertificate(certificate: certificate)
              .tabItem {
                Text("Certificate")
              }
          }
        }
        .frame(height: height)
        .padding(.vertical)
        TabView {
          if !payload.payloadProperties.isEmpty {
            PayloadProperties(type: .payload, properties: payload.payloadProperties, spacing: spacing)
              .tabItem {
                Text("Payload Properties")
              }
          }
          if !payload.availableProperties.isEmpty {
            PayloadProperties(type: .available, properties: payload.availableProperties, spacing: spacing)
              .tabItem {
                Text("Available Properties")
              }
          }
          if !payload.unknownProperties.isEmpty {
            PayloadProperties(type: .unknown, properties: payload.unknownProperties, spacing: spacing)
              .tabItem {
                Text("Unknown Properties")
              }
          }
          if !payload.general {
            DetailPropertyList(string: payload.propertyListString)
              .tabItem {
                Text("Property List")
              }
          }
        }
      }
      Spacer()
    }
    .padding()
    .frame(maxWidth: .infinity, maxHeight: .infinity)
  }
}
