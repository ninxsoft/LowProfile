//
//  DetailDiscussion.swift
//  Low Profile
//
//  Created by Nindi Gill on 6/12/21.
//

import SwiftUI

struct DetailDiscussion: View {
    var discussion: [String]
    private var string: String {
        discussion.joined(separator: "\n\n")
    }

    var body: some View {
        ScrollView(.vertical) {
            AttributedText(string: string)
        }
        .padding()
    }
}

struct DetailDiscussion_Previews: PreviewProvider {
    static var previews: some View {
        DetailDiscussion(discussion: [])
    }
}
