//
//  IssuesView.swift
//  Low Profile
//
//  Created by Nindi Gill on 23/5/2023.
//

import SwiftUI

struct IssuesView: View {
    var issues: [Issue]
    @Binding var selectedProfile: Profile?
    @Binding var selectedPayload: Payload?
    @Binding var selectedDetailTab: DetailTab
    @Binding var selectedProperty: Property?
    @State private var issueType: IssueType = .deprecated
    private let width: CGFloat = 540
    private let height: CGFloat = 400

    var body: some View {
        // swiftlint:disable:next closure_body_length
        VStack(spacing: 0) {
            Picker("Issue Type", selection: $issueType) {
                ForEach(IssueType.allCases) { issueType in
                    Text("\(issueType.pluralDescription.capitalized) (\(issues.filter { $0.type == issueType }.count))")
                        .tag(issueType)
                }
            }
            .pickerStyle(.segmented)
            .labelsHidden()
            .padding()
            if !issues.filter({ $0.type == issueType }).isEmpty {
                List {
                    ForEach(issues.filter { $0.type == issueType }) { issue in
                        IssuesHeadingView(issue: issue)
                        if !issue.profiles.isEmpty {
                            IssuesDetailProfilesView(
                                propertyName: issue.propertyName,
                                profiles: issue.profiles,
                                selectedProfile: $selectedProfile,
                                selectedPayload: $selectedPayload,
                                selectedDetailTab: $selectedDetailTab,
                                selectedProperty: $selectedProperty
                            )
                        } else if !issue.payloads.isEmpty {
                            IssuesDetailPayloadsView(
                                propertyName: issue.propertyName,
                                payloads: issue.payloads,
                                selectedPayload: $selectedPayload,
                                selectedDetailTab: $selectedDetailTab,
                                selectedProperty: $selectedProperty
                            )
                        }
                    }
                }
            } else {
                Spacer()
                Text("No \(issueType.pluralDescription) detected 🥳")
                    .font(.largeTitle)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.secondary)
                Spacer()
            }
        }
        .textSelection(.enabled)
        .frame(width: width, height: height)
    }
}

struct IssuesView_Previews: PreviewProvider {
    static var previews: some View {
        IssuesView(
            issues: [.example],
            selectedProfile: .constant(.example),
            selectedPayload: .constant(.example),
            selectedDetailTab: .constant(.payloadProperties),
            selectedProperty: .constant(.example)
        )
    }
}
