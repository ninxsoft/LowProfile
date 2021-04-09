//
//  CopyButton.swift
//  Low Profile
//
//  Created by Nindi Gill on 7/4/21.
//

import SwiftUI

struct CopyButton: View {
    var string: String

    var body: some View {
        Button("Copy") {
            copyToPasteboard(string)
        }
    }

    private func copyToPasteboard(_ string: String) {
        NSPasteboard.general.setString(string, forType: .string)
    }
}

struct CopyButton_Previews: PreviewProvider {
    static var previews: some View {
        CopyButton(string: "String")
    }
}
