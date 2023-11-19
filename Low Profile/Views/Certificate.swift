//
//  Certificate.swift
//  Low Profile
//
//  Created by Nindi Gill on 6/12/21.
//

import ASN1Decoder
import SwiftUI

struct Certificate: View {
    var certificate: X509Certificate
    var certificateImageLength: CGFloat
    private let spacing: CGFloat = 10
    private var validImagelength: CGFloat {
        certificateImageLength / 5
    }

    private var subjectString: String {
        // CN = 2.5.4.3

        guard
            let oid: OID = OID(rawValue: "2.5.4.3"),
            let string: String = certificate.subject(oid: oid)?.first else {
            return ""
        }

        return string
    }

    private var issuerString: String {
        // CN = 2.5.4.3

        guard
            let oid: OID = OID(rawValue: "2.5.4.3"),
            let string: String = certificate.issuer(oid: oid) else {
            return ""
        }

        return "Issued by: " + string
    }

    private var dateString: String {
        guard let date: Date = certificate.notAfter else {
            return ""
        }

        let expired: Bool = date < Date()
        let dateFormatter: DateFormatter = .init()
        dateFormatter.dateStyle = .full
        dateFormatter.timeStyle = .full
        let string: String = dateFormatter.string(from: date)
        return "Expire\(expired ? "d" : "s"): " + string
    }

    private var valid: Bool {
        certificate.checkValidity()
    }

    private var validString: String {
        "This certificate is " + (valid ? "" : "in") + "valid"
    }

    private var systemName: String {
        valid ? "checkmark.seal.fill" : "xmark.seal.fill"
    }

    var body: some View {
        HStack(spacing: spacing) {
            VStack {
                ScaledImage(name: "Certificate", length: certificateImageLength)
                Spacer()
            }
            VStack(alignment: .leading) {
                Text(subjectString)
                    .bold()
                Text(issuerString)
                    .fontWeight(.medium)
                Text(dateString)
                HStack {
                    ScaledSystemImage(systemName: systemName, length: validImagelength)
                        .foregroundColor(valid ? .green : .red)
                    Text(validString)
                        .foregroundColor(.secondary)
                }
            }
        }
    }
}
