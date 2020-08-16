//
//  DetailCertificate.swift
//  Low Profile
//
//  Created by Nindi Gill on 10/8/20.
//

import SwiftUI
import ASN1Decoder

struct DetailCertificate_Previews: PreviewProvider {
  static var previews: some View {
    DetailCertificate(certificate: nil)
  }
}

struct DetailCertificate: View {
  var certificate: X509Certificate?
  private var subjectString: String {

    // CN = 2.5.4.3
    let oid: String = "2.5.4.3"

    guard let certificate: X509Certificate = certificate,
          let string: String = certificate.subject(oid: oid) else {
      return ""
    }

    return string
  }

  private var issuerString: String {

    // CN = 2.5.4.3
    let oid: String = "2.5.4.3"

    guard let certificate: X509Certificate = certificate,
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
    return "This certificate is " + (valid ? "" : "in") + "valid"
  }
  private let spacing: CGFloat = 15
  private let certificateImageLength: CGFloat = 100
  private let validImagelength: CGFloat = 18

  var body: some View {
    VStack {
      Text("This profile is signed with the following certificate:")
        .font(.title3)
        .foregroundColor(.secondary)
      HStack(spacing: spacing) {
        Spacer()
        Image("Certificate")
          .resizable()
          .scaledToFit()
          .frame(width: certificateImageLength, height: certificateImageLength)
        VStack(alignment: .leading) {
          Text(subjectString)
            .bold()
          Text(issuerString)
            .fontWeight(.medium)
          Text(dateString)
          HStack {
            Image(systemName: valid ? "checkmark.seal.fill" : "xmark.seal.fill")
              .resizable()
              .scaledToFit()
              .frame(width: validImagelength, height: validImagelength)
              .foregroundColor(valid ? .green : .red)
            Text(validString)
              .foregroundColor(.secondary)
          }
        }
        Spacer()
      }
    }
    .padding()
  }
}
