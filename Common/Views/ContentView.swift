//
//  ContentView.swift
//  Low Profile
//
//  Created by Nindi Gill on 2/8/20.
//

import SwiftUI

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView(profile: .example)
  }
}

struct ContentView: View {
  @Environment(\.colorScheme) var colorScheme: ColorScheme
  @Environment(\.openURL) var openURL: OpenURLAction
  var profile: Profile
  @State var selection: Payload?
  private let width: CGFloat = 1200
  private let height: CGFloat = 720

  var body: some View {
    HStack(spacing: 0) {
      Sidebar(payloads: profile.payloads, selection: $selection)
      Divider()
      if selection == nil {
        UnselectedDetail(profile: profile)
      } else {
        ForEach(profile.payloads) { payload in
          if payload == selection {
            Detail(payload: payload, certificate: profile.certificate)
          }
        }
      }
    }
    .toolbar(items: {
      ToolbarItem {
        Button(action: {
          homepage()
        }, label: {
          Image(systemName: "questionmark.circle")
        })
      }
    })
    .frame(minWidth: width, maxWidth: .infinity, minHeight: height, maxHeight: .infinity)
  }

  private func homepage() {

    let string: String = "https://github.com/ninxsoft/LowProfile"

    guard let url: URL = URL(string: string) else {
      return
    }

    openURL(url)
  }
}
