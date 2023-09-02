//
//  IssuesHeadingView.swift
//  Low Profile
//
//  Created by Nindi Gill on 27/6/2023.
//

import SwiftUI

struct IssuesHeadingView: View {
    var issue: Issue

    var body: some View {
        Text("The ") +
        Text(issue.propertyName)
            .font(.system(.body, design: .monospaced))
            .bold() +
        Text(" property is \(issue.type.description) in the following payloads:")
    }
}

struct IssuesHeadingView_Previews: PreviewProvider {
    static var previews: some View {
        IssuesHeadingView(issue: .example)
    }
}
