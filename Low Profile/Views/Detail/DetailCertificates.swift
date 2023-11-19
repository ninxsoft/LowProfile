//
//  DetailCertificates.swift
//  Low Profile
//
//  Created by Nindi Gill on 10/8/20.
//

import ASN1Decoder
import SwiftUI

struct DetailCertificates: View {
    var certificates: [X509Certificate]
    private let certificateImageLength: CGFloat = 100

    var body: some View {
        VStack {
            Text("This profile is signed with the following certificate(s):")
                .font(.title3)
                .foregroundColor(.secondary)
            ScrollView(.vertical) {
                VStack(alignment: .leading) {
                    ForEach(0 ..< certificates.count, id: \.self) { index in
                        Certificate(certificate: certificates[index], certificateImageLength: certificateImageLength)
                        if index != certificates.count - 1 {
                            HStack {
                                Image(systemName: "arrow.down")
                            }
                            .frame(width: certificateImageLength)
                        }
                    }
                }
            }
        }
        .padding()
    }
}

struct DetailCertificates_Previews: PreviewProvider {
    static var previews: some View {
        DetailCertificates(certificates: [])
    }
}
