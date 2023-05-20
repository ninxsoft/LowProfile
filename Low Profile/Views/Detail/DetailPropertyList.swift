//
//  DetailPropertyList.swift
//  Low Profile
//
//  Created by Nindi Gill on 15/8/20.
//

import HighlightSwift
import SwiftUI

struct DetailPropertyList: View {
    var string: String
    @AppStorage("SyntaxHighlightingTheme")
    private var syntaxHighlightingTheme: String = "GitHub"
    private var highlightStyleName: HighlightStyle.Name {
        HighlightStyle.Name(rawValue: syntaxHighlightingTheme) ?? .github
    }

    var body: some View {
        ScrollView(.vertical) {
            HStack {
                CodeText(string, style: highlightStyleName)
                Spacer()
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
