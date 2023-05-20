//
//  SettingsSyntaxHighlightingView.swift
//  Low Profile
//
//  Created by Nindi Gill on 21/5/2023.
//

import HighlightSwift
import SwiftUI

struct SettingsSyntaxHighlightingView: View {
    @AppStorage("SyntaxHighlightingTheme")
    private var syntaxHighlightingTheme: String = "GitHub"
    private var highlightStyleName: HighlightStyle.Name {
        HighlightStyle.Name(rawValue: syntaxHighlightingTheme) ?? .github
    }
    private var width: CGFloat = 300
    private var height: CGFloat = 400
    private var string: String = """
    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
    <plist version="1.0">
    <dict>
        <key>AllowList</key>
        <array>
            <string>Foo</string>
            <string>Bar</string>
            <string>Baz</string>
        </array>
        <key>Enabled</key>
        <true/>
        <key>Limit</key>
        <integer>9000</integer>
        <key>Name</key>
        <string>Ninxsoft</string>
    </dict>
    </plist>
    """

    var body: some View {
        VStack {
            HStack {
                Text("Select a color theme to highlight Property Lists and custom properties:")
                Spacer()
            }
            HStack {
                List(HighlightStyle.Name.allCases, selection: $syntaxHighlightingTheme) { name in
                    Text(name.rawValue)
                }
                Divider()
                GroupBox {
                    ScrollView(.horizontal) {
                        VStack {
                            CodeText(string, style: highlightStyleName)
                            Spacer()
                        }
                    }
                }
                .frame(width: width)
            }
        }
        .padding()
        .frame(height: height)
    }
}

struct SettingsSyntaxHighlightingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsSyntaxHighlightingView()
    }
}
