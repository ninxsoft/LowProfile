//
//  PlatformTag.swift
//  Low Profile
//
//  Created by Nindi Gill on 6/8/20.
//

import SwiftUI

struct PlatformTag: View {
    var title: String
    private let length: CGFloat = 24
    private var symbolName: String {
        switch title {
        case "macOS":
            return "desktopcomputer"
        case "iOS":
            return "ipad"
        case "tvOS":
            return "appletv"
        case "watchOS":
            return "applewatch"
        default:
            return ""
        }
    }

    var body: some View {
        Image(systemName: symbolName)
            .resizable()
            .scaledToFit()
            .frame(width: length, height: length)
    }
}

struct PlatformTag_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ForEach(["macOS", "iOS", "tvOS", "watchOS"], id: \.self) { title in
                PlatformTag(title: title)
            }
        }
    }
}
