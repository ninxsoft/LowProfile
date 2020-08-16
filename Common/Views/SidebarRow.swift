//
//  SidebarRow.swift
//  Low Profile
//
//  Created by Nindi Gill on 3/8/20.
//

import SwiftUI

struct SidebarRow_Previews: PreviewProvider {
  static var previews: some View {
    SidebarRow(payload: .example)
  }
}

struct SidebarRow: View {
  var payload: Payload
  private let length: CGFloat = 48
  private let spacing: CGFloat = 5

  var body: some View {
    HStack(spacing: 0) {
      Image(nsImage: payload.image)
        .resizable()
        .scaledToFit()
        .frame(width: length, height: length)
        .padding(.trailing)
      VStack(alignment: .leading, spacing: spacing) {
        Text(payload.name)
          .bold()
          .lineLimit(2)
          .fixedSize(horizontal: false, vertical: false)
        HStack {
          ForEach(payload.platforms) { platform in
            PlatformTag(title: platform.name)
          }
          if payload.deprecated {
            TextTag(title: "Deprecated")
          }
          if payload.beta {
            TextTag(title: "Beta")
          }
        }
      }
    }
    .padding(.vertical)
  }
}
