//
//  DetailCertificate.swift
//  Low Profile
//
//  Created by Nindi Gill on 10/8/20.
//

import ASN1Decoder
import SwiftUI

struct DetailCertificate: View {
    var certificate: X509Certificate?
    private let spacing: CGFloat = 10
    private let certificateImageLength: CGFloat = 100
    private let validImagelength: CGFloat = 18
    private var subjectString: String {

        // CN = 2.5.4.3

        guard let oid: OID = OID(rawValue: "2.5.4.3"),
            let certificate: X509Certificate = certificate,
            let string: String = certificate.subject(oid: oid)?.first else {
            return ""
        }

        return string
    }
    private var issuerString: String {

        // CN = 2.5.4.3

        guard let oid: OID = OID(rawValue: "2.5.4.3"),
            let certificate: X509Certificate = certificate,
            let string: String = certificate.issuer(oid: oid) else {
            return ""
        }

        return "Issued by: " + string
    }
    private var dateString: String {

        guard let certificate: X509Certificate = certificate,
            let date: Date = certificate.notAfter else {
            return ""
        }

        let expired: Bool = date < Date()
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateStyle = .full
        dateFormatter.timeStyle = .full
        let string: String = dateFormatter.string(from: date)
        return "Expire\(expired ? "d" : "s"): " + string
    }
    private var valid: Bool {

        guard let certificate: X509Certificate = certificate else {
            return false
        }

        return certificate.checkValidity()
    }
    private var validString: String {
        "This certificate is " + (valid ? "" : "in") + "valid"
    }
    private var systemName: String {
        valid ? "checkmark.seal.fill" : "xmark.seal.fill"
    }

    var body: some View {
        VStack {
            Text("This profile is signed with the following certificate:")
                .font(.title3)
                .foregroundColor(.secondary)
            ScrollView(.vertical) {
                HStack(spacing: spacing) {
                    Spacer()
                    ScaledImage(name: "Certificate", length: certificateImageLength)
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
                    Spacer()
                }
            }
        }
        .padding()
    }
}

struct DetailCertificate_Previews: PreviewProvider {
    static var previews: some View {
        DetailCertificate(certificate: nil)
    }
}
