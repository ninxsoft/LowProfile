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
    private var hasDuplicateProperties: Bool {
        !issues.compactMap { $0.duplicatedProperty }.isEmpty
    }
    private var hasDeprecatedProperties: Bool {
        !issues.compactMap { $0.deprecatedProperty }.isEmpty
    }

    var body: some View {
        // swiftlint:disable:next closure_body_length
        List {
            if hasDuplicateProperties {
                Section(header: Text("Duplicated Properties")) {
                    ForEach(issues) { issue in
                        if let duplicatedProperty: String = issue.duplicatedProperty {
                            IssuesHeadingView(propertyName: duplicatedProperty, description: "duplicated")
                            if !issue.profiles.isEmpty {
                                IssuesDetailProfilesView(
                                    propertyName: duplicatedProperty,
                                    profiles: issue.profiles,
                                    selectedProfile: $selectedProfile,
                                    selectedPayload: $selectedPayload,
                                    selectedDetailTab: $selectedDetailTab,
                                    selectedProperty: $selectedProperty
                                )
                            } else if !issue.payloads.isEmpty {
                                IssuesDetailPayloadsView(
                                    propertyName: duplicatedProperty,
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
            if hasDeprecatedProperties {
                Section(header: Text("Deprecated Properties")) {
                    ForEach(issues) { issue in
                        if let deprecatedProperty: String = issue.deprecatedProperty {
                            IssuesHeadingView(propertyName: deprecatedProperty, description: "deprecated")
                            if !issue.profiles.isEmpty {
                                IssuesDetailProfilesView(
                                    propertyName: deprecatedProperty,
                                    profiles: issue.profiles,
                                    selectedProfile: $selectedProfile,
                                    selectedPayload: $selectedPayload,
                                    selectedDetailTab: $selectedDetailTab,
                                    selectedProperty: $selectedProperty
                                )
                            } else if !issue.payloads.isEmpty {
                                IssuesDetailPayloadsView(
                                    propertyName: deprecatedProperty,
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
