//
//  IssuesHeadingView.swift
//  Low Profile
//
//  Created by Nindi Gill on 27/6/2023.
//

import SwiftUI

struct IssuesHeadingView: View {
    var propertyName: String
    var description: String

    var body: some View {
        Text("The ") +
        Text(propertyName)
            .font(.system(.body, design: .monospaced))
            .bold() +
        Text(" property is \(description) in the following payloads:")
    }
}

struct IssuesHeadingView_Previews: PreviewProvider {
    static var previews: some View {
        IssuesHeadingView(propertyName: Property.example.name, description: "duplicated")
    }
}
