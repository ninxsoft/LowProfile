//
//  ProfileDocumentView.swift
//  Low Profile
//
//  Created by Nindi Gill on 2/8/20.
//

import SwiftUI

struct ProfileDocumentView: View {
    @Environment(\.openURL)
    var openURL: OpenURLAction
    var profile: Profile
    @State private var selectedPayload: Payload?
    @State private var selectedDetailTab: DetailTab = .information
    @State private var selectedProperty: Property?
    @State private var issues: [Issue] = []
    @State private var showIssuesPopover: Bool = false
    @State private var searchString: String = ""
    private var issuesButtonSystemName: String {
        issues.isEmpty ? "checkmark.circle" : "exclamationmark.triangle"
    }

    private var issuesButtonForegroundColor: Color {
        issues.isEmpty ? .green : .orange
    }

    private let sidebarWidth: CGFloat = 275
    private let width: CGFloat = 1_260
    private let height: CGFloat = 720

    var body: some View {
        NavigationSplitView {
            List(profile.payloads, id: \.id, selection: $selectedPayload) { payload in
                NavigationLink(value: payload) {
                    SidebarPayloadRow(payload: payload)
                }
            }
            .frame(minWidth: sidebarWidth)
        } detail: {
            if let payload: Payload = selectedPayload {
                Detail(payload: payload, certificates: profile.certificates, selectedDetailTab: $selectedDetailTab, selectedProperty: $selectedProperty)
            } else {
                Text("Select a Payload to view its contents 🙂")
                    .font(.title)
                    .foregroundColor(.secondary)
            }
        }
        .searchable(text: $searchString, prompt: Text("Name, identifier or property"))
        .searchSuggestions {
            ForEach(filteredPayloads()) { payload in
                ResultsTitleView(title: payload.name, image: payload.name)
                    .tag(payload.payloadUUID)
                    .onTapGesture {
                        selectedPayload = payload
                        selectedDetailTab = .information
                        searchString = ""
                    }
                ForEach(PropertySection.allCases) { propertySection in
                    ForEach(filteredProperties(for: propertySection, using: payload)) { property in
                        ResultsKeyView(title: property.name, bold: false, indentation: 1)
                            .tag("\(payload.payloadUUID).\(property.name)")
                            .onTapGesture {
                                setSelectedPropertyState(payload: payload, detailTab: detailTab(for: propertySection), property: property)
                            }
                    }
                }
            }
        }
        .toolbar {
            if !issues.isEmpty {
                ToolbarItem {
                    Text("\(issues.count) issue\(issues.count == 1 ? "" : "s") detected")
                }
            }
            ToolbarItem {
                Button(action: {
                    showIssuesPopover = true
                }, label: {
                    Image(systemName: issuesButtonSystemName)
                        .foregroundColor(issuesButtonForegroundColor)
                })
                .help("Issues")
                .popover(isPresented: $showIssuesPopover, arrowEdge: .bottom) {
                    if !issues.isEmpty {
                        IssuesView(issues: issues, selectedProfile: .constant(profile), selectedPayload: $selectedPayload, selectedDetailTab: $selectedDetailTab, selectedProperty: $selectedProperty)
                    } else {
                        Text("No issues detected, everything looks good 🥳").padding()
                    }
                }
            }
            ToolbarItem {
                Button(action: {
                    homepage()
                }, label: {
                    Image(systemName: "questionmark.circle")
                        .foregroundColor(.accentColor)
                })
                .help("Visit Website")
            }
        }
        .frame(minWidth: width, minHeight: height)
        .onAppear {
            selectedPayload = profile.payloads.first
            issues = IssuesHelper.shared.getIssues(for: profile)
        }
    }

    private func filteredPayloads() -> [Payload] {
        profile.payloads.filter {
            $0.name.lowercased().contains(searchString.lowercased()) ||
            $0.payloadIdentifier.lowercased().contains(searchString.lowercased()) ||
            !$0.payloadProperties.map(\.name).filter { $0.lowercased().contains(searchString.lowercased()) }.isEmpty ||
            !$0.availableProperties.map(\.name).filter { $0.lowercased().contains(searchString.lowercased()) }.isEmpty ||
            !$0.unknownProperties.map(\.name).filter { $0.lowercased().contains(searchString.lowercased()) }.isEmpty
        }
    }

    private func filteredProperties(for propertySection: PropertySection, using payload: Payload) -> [Property] {
        switch propertySection {
        case .payload:
            return payload.payloadProperties.filter { $0.name.lowercased().contains(searchString.lowercased()) }
        case .available:
            return payload.availableProperties.filter { $0.name.lowercased().contains(searchString.lowercased()) }
        case .unknown:
            return payload.unknownProperties.filter { $0.name.lowercased().contains(searchString.lowercased()) }
        }
    }

    private func detailTab(for propertySection: PropertySection) -> DetailTab {
        switch propertySection {
        case .payload:
            return .payloadProperties
        case .available:
            return .availableProperties
        case .unknown:
            return .unknownProperties
        }
    }

    private func setSelectedPropertyState(payload: Payload, detailTab: DetailTab, property: Property) {
        selectedPayload = payload
        selectedDetailTab = detailTab
        selectedProperty = property
        searchString = ""
    }

    private func homepage() {
        guard let url: URL = URL(string: .repositoryURL) else {
            return
        }

        openURL(url)
    }
}

struct ProfileDocumentView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileDocumentView(profile: .example)
    }
}
