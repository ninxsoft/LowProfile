//
//  DetailDiscussion.swift
//  Low Profile
//
//  Created by Nindi Gill on 9/8/20.
//

import SwiftUI

struct DetailDiscussion: View {
    var discussion: String
    private var formattedDiscussion: String {
        discussion.replacingOccurrences(of: "<>", with: "")
            .replacingOccurrences(of: "<code>", with: "")
            .replacingOccurrences(of: "</code>", with: "")
            .replacingOccurrences(of: "<emphasis>", with: "")
            .replacingOccurrences(of: "</emphasis>", with: "")
            .replacingOccurrences(of: "[", with: "")
            .replacingOccurrences(of: "]", with: " - ")
    }

    var body: some View {
        VStack {
            ScrollView(.vertical) {
                HStack {
                    AttributedText(string: discussion)
                        .contextMenu {
                            CopyButton(string: formattedDiscussion)
                        }
                    Spacer()
                }
            }
        }
        .padding()
    }
}

struct DetailDiscussion_Previews: PreviewProvider {
    static var previews: some View {
        DetailDiscussion(discussion: "Example")
    }
}
