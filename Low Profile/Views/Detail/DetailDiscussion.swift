//
//  DetailDiscussion.swift
//  Low Profile
//
//  Created by Nindi Gill on 6/12/21.
//

import Highlightr
import SwiftUI

struct DetailDiscussion: View {
    @Environment(\.colorScheme)
    var colorScheme: ColorScheme
    var payload: Payload
    @AppStorage("SyntaxHighlightingTheme")
    private var syntaxHighlightingTheme: String = .syntaxHighlightingThemeDefault
    private var discussionString: String {
        payload.discussion.joined(separator: "\n\n")
    }
    @State private var propertyList: AttributedString = AttributedString()

    var body: some View {
        VStack {
            AttributedText(string: discussionString)
                .font(.title3)
                .padding(.bottom)
            if !payload.general {
                HStack {
                    Text("Example Property List")
                        .font(.title)
                    Spacer()
                }
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
            }
            Spacer()
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

        propertyList = highlightr.highlight(payload.example)
    }
}

struct DetailDiscussion_Previews: PreviewProvider {
    static var previews: some View {
        DetailDiscussion(payload: .example)
    }
}
