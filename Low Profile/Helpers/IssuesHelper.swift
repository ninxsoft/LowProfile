//
//  IssuesHelper.swift
//  Low Profile
//
//  Created by Nindi Gill on 23/5/2023.
//

import Foundation

class IssuesHelper: NSObject {

    static let shared: IssuesHelper = IssuesHelper()

    func getIssues(for profiles: [Profile]) -> [Issue] {
        getDuplicateIssues(for: profiles) + getDeprecationIssues(for: profiles)
    }

    func getIssues(for profile: Profile) -> [Issue] {
        getDuplicateIssues(for: profile) + getDeprecationIssues(for: profile)
    }

    private func getDuplicateIssues(for profiles: [Profile]) -> [Issue] {
        var issues: [Issue] = []

        for outerProfile in profiles {
            for outerPayload in outerProfile.payloads where !outerPayload.general {
                for property in outerPayload.payloadProperties {
                    var profilesWithDuplicatedProperties: [Profile] = []

                    for innerProfile in profiles {
                        for innerPayload in innerProfile.payloads where innerPayload != outerPayload && !innerPayload.general &&
                            innerPayload.payloadProperties.map({ $0.name }).contains(property.name) {
                            profilesWithDuplicatedProperties.append(innerProfile)
                        }
                    }

                    if !profilesWithDuplicatedProperties.isEmpty && !issues.map({ $0.duplicatedProperty }).contains(property.name) {
                        let issue: Issue = Issue(id: UUID().uuidString, profiles: profilesWithDuplicatedProperties, duplicatedProperty: property.name)
                        issues.append(issue)
                    }
                }
            }
        }

        return issues
    }

    private func getDuplicateIssues(for profile: Profile) -> [Issue] {
        var issues: [Issue] = []

        for outerPayload in profile.payloads where profile.payloads.filter({ outerPayload.type == $0.type }).count > 1 {
            for property in outerPayload.payloadProperties {
                var payloadsWithDuplicatedProperties: [Payload] = []

                for innerPayload in profile.payloads where innerPayload.payloadProperties.map({ $0.name }).contains(property.name) {
                    payloadsWithDuplicatedProperties.append(innerPayload)
                }

                if !payloadsWithDuplicatedProperties.isEmpty && !issues.map({ $0.duplicatedProperty }).contains(property.name) {
                    let issue: Issue = Issue(id: UUID().uuidString, payloads: payloadsWithDuplicatedProperties, duplicatedProperty: property.name)
                    issues.append(issue)
                }
            }
        }

        return issues
    }

    private func getDeprecationIssues(for profiles: [Profile]) -> [Issue] {
        var issues: [Issue] = []

        for outerProfile in profiles {
            for outerPayload in outerProfile.payloads {
                for property in outerPayload.payloadProperties.filter({ $0.deprecated }) {
                    var profilesWithDeprecatedProperties: [Profile] = []

                    for innerProfile in profiles {
                        for innerPayload in innerProfile.payloads where innerPayload.payloadProperties.map({ $0.name }).contains(property.name) {
                            profilesWithDeprecatedProperties.append(innerProfile)
                        }
                    }

                    if !profilesWithDeprecatedProperties.isEmpty && !issues.map({ $0.deprecatedProperty }).contains(property.name) {
                        let issue: Issue = Issue(id: UUID().uuidString, profiles: profilesWithDeprecatedProperties, deprecatedProperty: property.name)
                        issues.append(issue)
                    }
                }
            }
        }

        return issues
    }

    private func getDeprecationIssues(for profile: Profile) -> [Issue] {
        var issues: [Issue] = []

        for outerPayload in profile.payloads {
            for property in outerPayload.payloadProperties.filter({ $0.deprecated }) {
                var payloadsWithDeprecatedProperties: [Payload] = []

                for innerPayload in profile.payloads where innerPayload.payloadProperties.map({ $0.name }).contains(property.name) {
                    payloadsWithDeprecatedProperties.append(innerPayload)
                }

                if !payloadsWithDeprecatedProperties.isEmpty && !issues.map({ $0.deprecatedProperty }).contains(property.name) {
                    let issue: Issue = Issue(id: UUID().uuidString, payloads: payloadsWithDeprecatedProperties, deprecatedProperty: property.name)
                    issues.append(issue)
                }
            }
        }

        return issues
    }
}
