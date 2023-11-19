//
//  SettingsSyntaxHighlightingView.swift
//  Low Profile
//
//  Created by Nindi Gill on 21/5/2023.
//

import Highlightr
import SwiftUI

struct SettingsSyntaxHighlightingView: View {
    @Environment(\.colorScheme)
    var colorScheme: ColorScheme
    @AppStorage("SyntaxHighlightingTheme")
    private var syntaxHighlightingTheme: String = .syntaxHighlightingThemeDefault
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
    private var propertyList: AttributedString {
        guard let highlightr: Highlightr = Highlightr() else {
            return AttributedString()
        }

        if !highlightr.setTheme(to: highlightr.themeVariant(for: syntaxHighlightingTheme, using: colorScheme)) {
            highlightr.setTheme(to: highlightr.themeVariant(for: .syntaxHighlightingThemeDefault, using: colorScheme))
        }

        return highlightr.highlight(string)
    }
    private var width: CGFloat = 300
    private var height: CGFloat = 350

    var body: some View {
        VStack {
            HStack {
                Text("Select a color theme to highlight Property Lists and custom properties:")
                Spacer()
            }
            HStack {
                List(Highlightr.propertyListThemes(), id: \.self, selection: $syntaxHighlightingTheme) { name in
                    Text(name)
                        .tag(name)
                }
                Divider()
                GroupBox {
                    ScrollView([.horizontal, .vertical]) {
                        ScrollViewReader { value in
                            Text(propertyList)
                                .id(0)
                                .onAppear {
                                    value.scrollTo(0, anchor: .topLeading)
                                }
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
