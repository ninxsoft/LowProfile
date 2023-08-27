//
//  DetailPropertyList.swift
//  Low Profile
//
//  Created by Nindi Gill on 15/8/20.
//

import Highlightr
import SwiftUI

struct DetailPropertyList: View {
    var string: String
    @AppStorage("SyntaxHighlightingTheme")
    private var syntaxHighlightingTheme: String = .syntaxHighlightingThemeDefault
    private var propertyList: AttributedString? {

        guard let highlightr: Highlightr = Highlightr() else {
            return nil
        }

        if !highlightr.setTheme(to: syntaxHighlightingTheme) {
            highlightr.setTheme(to: .syntaxHighlightingThemeDefault)
        }

        return highlightr.highlight(string)
    }

    var body: some View {
        ScrollView([.horizontal, .vertical]) {
            HStack {
                ScrollView([.horizontal, .vertical]) {
                    Text(propertyList ?? "")
                }
            }
        }
        .padding()
    }
}

struct DetailPropertyList_Previews: PreviewProvider {
    static var previews: some View {
        DetailPropertyList(string: "Example")
    }
}
