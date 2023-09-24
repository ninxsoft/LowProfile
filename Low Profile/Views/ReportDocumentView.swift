//
//  ReportDocumentView.swift
//  Low Profile
//
//  Created by Nindi Gill on 29/8/2023.
//

import SwiftUI

struct ReportDocumentView: View {
    @Environment(\.openURL)
    var openURL: OpenURLAction
    var profiles: [Profile]
    @State private var selectedProfile: Profile?
    @State private var selectedPayload: Payload?
    @State private var previousSelections: [String: String] = [:]
    @State private var selectedDetailTab: DetailTab = .information
    @State private var selectedProperty: Property?
    @State private var searchString: String = ""
    @State private var issues: [Issue] = []
    @State private var showIssuesPopover: Bool = false
    private var issuesButtonSystemName: String {
        issues.isEmpty ? "checkmark.circle" : "exclamationmark.triangle"
    }
    private var issuesButtonForegroundColor: Color {
        issues.isEmpty ? .green : .orange
    }
    private let profilesSidebarWidth: CGFloat = 250
    private let payloadsSidebarWidth: CGFloat = 275
    private let width: CGFloat = 1_260
    private let height: CGFloat = 720

    var body: some View {
        NavigationSplitView {
            List(profiles, selection: $selectedProfile) { profile in
                NavigationLink(value: profile) {
                    SidebarProfileRow(profile: profile)
                }
            }
            .frame(minWidth: profilesSidebarWidth)
        } content: {
            if let profile: Profile = selectedProfile {
                List(profile.payloads, selection: $selectedPayload) { payload in
                    NavigationLink(value: payload) {
                        SidebarPayloadRow(payload: payload)
                    }
                    .listRowSeparator(.hidden)
                }
                .frame(minWidth: payloadsSidebarWidth)
            } else {
                EmptyView()
                    .frame(width: payloadsSidebarWidth)
            }
        } detail: {
            if let profile: Profile = selectedProfile {
                if let payload: Payload = selectedPayload {
                    Detail(payload: payload, certificates: profile.certificates, selectedDetailTab: $selectedDetailTab, selectedProperty: $selectedProperty)
                } else {
                    Text("Select a Payload to view its contents 🙂")
                        .font(.largeTitle)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.secondary)
                }
            } else {
                Text(profiles.isEmpty ? "There are no Profiles in this report 🙃" : "Select a Profile to view its contents 🙂")
                    .font(.largeTitle)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.secondary)
            }
        }
        .searchable(text: $searchString, prompt: "Name, identifier or property")
        .searchSuggestions {
            ForEach(filteredProfiles()) { profile in
                ResultsTitleView(title: profile.name, image: "Profile")
                    .tag(profile.id)
                    .onTapGesture {
                        selectedProfile = profile
                        selectedPayload = nil
                        selectedDetailTab = .information
                        searchString = ""
                    }
                ForEach(filteredPayloads(for: profile)) { payload in
                    ResultsTitleView(title: payload.name, image: payload.name, indentation: 1)
                        .tag(payload.payloadUUID)
                        .onTapGesture {
                            selectedProfile = profile
                            selectedPayload = payload
                            selectedDetailTab = .information
                            searchString = ""
                        }
                    ForEach(PropertySection.allCases) { propertySection in
                        ForEach(filteredProperties(for: propertySection, using: payload)) { property in
                            ResultsKeyView(title: property.name, bold: false, indentation: 2)
                                .tag("\(payload.payloadUUID).\(property.name)")
                                .onTapGesture {
                                    setSelectedPropertyState(profile: profile, payload: payload, detailTab: detailTab(for: propertySection), property: property)
                                }
                        }
                    }
                }
            }
        }
        .toolbar {
            ToolbarItemGroup {
                if !issues.isEmpty {
                    Text("\(issues.count) issue\(issues.count == 1 ? "" : "s") detected")
                }
                Button(action: {
                    showIssuesPopover = true
                }, label: {
                    Image(systemName: issuesButtonSystemName)
                        .foregroundColor(issuesButtonForegroundColor)
                }).help("Issues")
                .popover(isPresented: $showIssuesPopover, arrowEdge: .bottom) {
                    if !issues.isEmpty {
                        IssuesView(issues: issues, selectedProfile: $selectedProfile, selectedPayload: $selectedPayload, selectedDetailTab: $selectedDetailTab, selectedProperty: $selectedProperty)
                    } else {
                        Text("No issues detected, everything looks good 🥳").padding()
                    }
                }
                Button {
                    homepage()
                } label: {
                    Label("Visit Website", systemImage: "questionmark.circle")
                        .foregroundColor(.accentColor)
                }.help("Visit Website")
            }
        }
        .frame(minWidth: width, minHeight: height)
        .onAppear {
            selectedProfile = profiles.first
            selectedPayload = selectedProfile?.payloads.first
            issues = IssuesHelper.shared.getIssues(for: profiles)
        }
        .onChange(of: selectedProfile) { profile in

            guard let profile: Profile = selectedProfile else {
                return
            }

            selectedPayload = profile.payloads.first { $0.id == previousSelections[profile.id] } ?? profile.payloads.first
        }
        .onChange(of: selectedPayload) { _ in

            guard let profile: Profile = selectedProfile,
                let payload: Payload = selectedPayload else {
                return
            }

            previousSelections[profile.id] = payload.id
        }
    }

    private func filteredProfiles() -> [Profile] {
        profiles.filter {
            $0.name.lowercased().contains(searchString.lowercased()) ||
            $0.id.lowercased().contains(searchString.lowercased()) ||
            !$0.payloads.filter {
                $0.name.lowercased().contains(searchString.lowercased()) ||
                $0.payloadIdentifier.lowercased().contains(searchString.lowercased()) ||
                !$0.payloadProperties.map { $0.name }.filter { $0.lowercased().contains(searchString.lowercased()) }.isEmpty ||
                !$0.availableProperties.map { $0.name }.filter { $0.lowercased().contains(searchString.lowercased()) }.isEmpty ||
                !$0.unknownProperties.map { $0.name }.filter { $0.lowercased().contains(searchString.lowercased()) }.isEmpty
            }.isEmpty
        }
    }

    private func filteredPayloads(for profile: Profile) -> [Payload] {
        profile.payloads.filter {
            $0.name.lowercased().contains(searchString.lowercased()) ||
            $0.payloadIdentifier.lowercased().contains(searchString.lowercased()) ||
            !$0.payloadProperties.map { $0.name }.filter { $0.lowercased().contains(searchString.lowercased()) }.isEmpty ||
            !$0.availableProperties.map { $0.name }.filter { $0.lowercased().contains(searchString.lowercased()) }.isEmpty ||
            !$0.unknownProperties.map { $0.name }.filter { $0.lowercased().contains(searchString.lowercased()) }.isEmpty
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

    private func setSelectedPropertyState(profile: Profile, payload: Payload, detailTab: DetailTab, property: Property) {
        selectedProfile = profile
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

struct ReportDocumentView_Previews: PreviewProvider {
    static var previews: some View {
        ReportDocumentView(profiles: [.example])
    }
}
