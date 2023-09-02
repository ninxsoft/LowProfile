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
        getDeprecatedIssues(for: profiles) + getDuplicatedIssues(for: profiles)
    }

    func getIssues(for profile: Profile) -> [Issue] {
        getDeprecatedIssues(for: profile) + getDuplicatedIssues(for: profile)
    }

    private func getDeprecatedIssues(for profiles: [Profile]) -> [Issue] {
        var issues: [Issue] = []
        var deprecatedPropertyNames: Set<String> = []

        for profile in profiles {
            for payload in profile.payloads {
                for property in payload.payloadProperties.filter({ $0.deprecated }) {
                    deprecatedPropertyNames.insert(property.name)
                }
            }
        }

        for deprecatedPropertyName in deprecatedPropertyNames {

            var profilesWithDeprecatedProperties: [Profile] = []

            for profile in profiles {
                for payload in profile.payloads where !payload.payloadProperties.filter({ $0.name == deprecatedPropertyName }).isEmpty {
                    profilesWithDeprecatedProperties.append(profile)
                    break
                }
            }

            if !profilesWithDeprecatedProperties.isEmpty {
                let issue: Issue = Issue(id: UUID().uuidString, type: .deprecated, propertyName: deprecatedPropertyName, profiles: profilesWithDeprecatedProperties)
                issues.append(issue)
            }
        }

        return issues
    }

    private func getDeprecatedIssues(for profile: Profile) -> [Issue] {
        var issues: [Issue] = []
        var deprecatedPropertyNames: Set<String> = []

        for payload in profile.payloads {
            for property in payload.payloadProperties.filter({ $0.deprecated }) {
                deprecatedPropertyNames.insert(property.name)
            }
        }

        for deprecatedPropertyName in deprecatedPropertyNames {

            var payloadsWithDeprecatedProperties: [Payload] = []

            for payload in profile.payloads where !payload.payloadProperties.filter({ $0.name == deprecatedPropertyName }).isEmpty {
                payloadsWithDeprecatedProperties.append(payload)
            }

            if !payloadsWithDeprecatedProperties.isEmpty {
                let issue: Issue = Issue(id: UUID().uuidString, type: .deprecated, propertyName: deprecatedPropertyName, payloads: payloadsWithDeprecatedProperties)
                issues.append(issue)
            }
        }

        return issues
    }

    private func getDuplicatedIssues(for profiles: [Profile]) -> [Issue] {
        var issues: [Issue] = []
        var duplicatedPropertyNames: Set<String> = []

        for outerProfile in profiles {
            for outerPayload in outerProfile.payloads {
                for outerProperty in outerPayload.payloadProperties {
                    for innerProfile in profiles {
                        for innerPayload in innerProfile.payloads where !innerPayload.availability.multiple.isEmpty && innerPayload != outerPayload && innerPayload.type == outerPayload.type {
                            for innerProperty in innerPayload.payloadProperties where innerProperty.name == outerProperty.name {
                                duplicatedPropertyNames.insert(outerProperty.name)
                            }
                        }
                    }
                }
            }
        }

        for duplicatedPropertyName in duplicatedPropertyNames {

            var profilesWithDuplicatedProperties: [Profile] = []

            for profile in profiles {
                for payload in profile.payloads where !payload.payloadProperties.filter({ $0.name == duplicatedPropertyName }).isEmpty {
                    profilesWithDuplicatedProperties.append(profile)
                    break
                }
            }

            if !profilesWithDuplicatedProperties.isEmpty {
                let issue: Issue = Issue(id: UUID().uuidString, type: .duplicated, propertyName: duplicatedPropertyName, profiles: profilesWithDuplicatedProperties)
                issues.append(issue)
            }
        }

        return issues
    }

    private func getDuplicatedIssues(for profile: Profile) -> [Issue] {
        var issues: [Issue] = []
        var duplicatedPropertyNames: Set<String> = []

        for outerPayload in profile.payloads {
            for outerProperty in outerPayload.payloadProperties {
                for innerPayload in profile.payloads where !innerPayload.availability.multiple.isEmpty && innerPayload != outerPayload && innerPayload.type == outerPayload.type {
                    for innerProperty in innerPayload.payloadProperties where innerProperty.name == outerProperty.name {
                        duplicatedPropertyNames.insert(outerProperty.name)
                    }
                }
            }
        }

        for duplicatedPropertyName in duplicatedPropertyNames {

            var payloadsWithDuplicatedProperties: [Payload] = []

            for payload in profile.payloads where !payload.payloadProperties.filter({ $0.name == duplicatedPropertyName }).isEmpty {
                payloadsWithDuplicatedProperties.append(payload)
            }

            if !payloadsWithDuplicatedProperties.isEmpty {
                let issue: Issue = Issue(id: UUID().uuidString, type: .duplicated, propertyName: duplicatedPropertyName, payloads: payloadsWithDuplicatedProperties)
                issues.append(issue)
            }
        }

        return issues
    }
}
