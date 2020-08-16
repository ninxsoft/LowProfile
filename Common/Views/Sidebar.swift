//
//  Sidebar.swift
//  Low Profile
//
//  Created by Nindi Gill on 5/8/20.
//

import SwiftUI

struct Sidebar_Previews: PreviewProvider {
  static var previews: some View {
    Sidebar(payloads: [.example], selection: .constant(nil))
  }
}

struct Sidebar: View {
  var payloads: [Payload]
  @Binding var selection: Payload?
  private let width: CGFloat = 250

  var body: some View {
    List(selection: $selection) {
      ForEach(payloads) { payload in
        SidebarRow(payload: payload)
          .tag(payload)
      }
    }
    .listStyle(SidebarListStyle())
    .frame(width: width)
  }
}
