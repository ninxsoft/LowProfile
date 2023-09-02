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
    private let width: CGFloat = 540
    private let height: CGFloat = 400
    private var hasDeprecatedProperties: Bool {
        !issues.filter { $0.type == .deprecated }.isEmpty
    }
    private var hasDuplicatedProperties: Bool {
        !issues.filter { $0.type == .duplicated }.isEmpty
    }

    var body: some View {
        // swiftlint:disable:next closure_body_length
        List {
            if hasDeprecatedProperties {
                Section(header: Text("Deprecated Properties")) {
                    ForEach(issues.filter { $0.type == .deprecated }) { issue in
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
            }
            if hasDuplicatedProperties {
                Section(header: Text("Duplicated Properties")) {
                    ForEach(issues.filter { $0.type == .duplicated }) { issue in
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
            }
        }
        .textSelection(.enabled)
        .frame(minWidth: width, minHeight: height)
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
