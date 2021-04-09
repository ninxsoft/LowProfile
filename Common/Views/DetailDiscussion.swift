//
//  DetailDiscussion.swift
//  Low Profile
//
//  Created by Nindi Gill on 9/8/20.
//

import SwiftUI

struct DetailDiscussion: View {
    var discussion: String

    var body: some View {
        VStack {
            ScrollView(.vertical) {
                HStack {
                    AttributedText(string: discussion)
                        .contextMenu {
                            CopyButton(string: discussion)
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
