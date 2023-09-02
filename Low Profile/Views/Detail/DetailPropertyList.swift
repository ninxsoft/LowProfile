//
//  DetailPropertyList.swift
//  Low Profile
//
//  Created by Nindi Gill on 15/8/20.
//

import Highlightr
import SwiftUI

struct DetailPropertyList: View {
    @Environment(\.colorScheme)
    var colorScheme: ColorScheme
    var string: String
    @AppStorage("SyntaxHighlightingTheme")
    private var syntaxHighlightingTheme: String = .syntaxHighlightingThemeDefault
    @State private var propertyList: AttributedString = AttributedString()

    var body: some View {
        ScrollView([.horizontal, .vertical]) {
            ScrollViewReader { value in
                Text(propertyList)
                    .id(0)
                    .onAppear {
                        value.scrollTo(0, anchor: .topLeading)
                    }
            }
        }
        .padding()
        .onAppear {
            updatePropertyList(using: colorScheme)
        }
        .onChange(of: syntaxHighlightingTheme) { _ in
            updatePropertyList(using: colorScheme)
        }
        .onChange(of: colorScheme) { colorScheme in
            updatePropertyList(using: colorScheme)
        }
    }

    private func updatePropertyList(using colorScheme: ColorScheme) {

        guard let highlightr: Highlightr = Highlightr() else {
            return
        }

        if !highlightr.setTheme(to: highlightr.themeVariant(for: syntaxHighlightingTheme, using: colorScheme)) {
            highlightr.setTheme(to: highlightr.themeVariant(for: .syntaxHighlightingThemeDefault, using: colorScheme))
        }

        propertyList = highlightr.highlight(string)
    }
}

struct DetailPropertyList_Previews: PreviewProvider {
    static var previews: some View {
        DetailPropertyList(string: "Example")
    }
}
