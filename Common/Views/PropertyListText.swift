//
//  PropertyListText.swift
//  Low Profile
//
//  Created by Nindi Gill on 15/8/20.
//

import SwiftUI

struct PropertyListText_Previews: PreviewProvider {
  static var previews: some View {
    PropertyListText(string: "Example")
  }
}

struct PropertyListText: View {
  var string: String
  var propertyListText: Text {
    let seperator: String = "<>"
    let xml: String = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>"
    // swiftlint:disable:next line_length
    let doctype: String = "<!DOCTYPE plist PUBLIC \"-//Apple//DTD PLIST 1.0//EN\" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\">"
    let plist: String = "<plist version=\"1.0\">"
    let unformattedStrings: [String] = string.surroundingOccurrences(of: xml, with: seperator)
                                             .surroundingOccurrences(of: doctype, with: seperator)
                                             .surroundingOccurrences(of: plist, with: seperator)
                                             .surroundingOccurrences(of: "<dict>", with: seperator)
                                             .surroundingOccurrences(of: "</dict>", with: seperator)
                                             .surroundingOccurrences(of: "<array>", with: seperator)
                                             .surroundingOccurrences(of: "</array>", with: seperator)
                                             .replacingOccurrences(of: "<key>", with: "<><key><><name>")
                                             .replacingOccurrences(of: "</key>", with: "</name><></key><>")
                                             .surroundingOccurrences(of: "<true/>", with: seperator)
                                             .surroundingOccurrences(of: "<false/>", with: seperator)
                                             .replacingOccurrences(of: "<data>", with: "<><data><><value>")
                                             .replacingOccurrences(of: "</data>", with: "</value><></data><>")
                                             .replacingOccurrences(of: "<date>", with: "<><date><><value>")
                                             .replacingOccurrences(of: "</date>", with: "</value><></date><>")
                                             .replacingOccurrences(of: "<integer>", with: "<><integer><><value>")
                                             .replacingOccurrences(of: "</integer>", with: "</value><></integer><>")
                                             .replacingOccurrences(of: "<real>", with: "<><real><><value>")
                                             .replacingOccurrences(of: "</real>", with: "</value><></real><>")
                                             .replacingOccurrences(of: "<string>", with: "<><string><><value>")
                                             .replacingOccurrences(of: "</string>", with: "</value><></string><>")
                                             .components(separatedBy: seperator)
    var propertyListText: Text = Text("")

    for unformattedString in unformattedStrings {

      var formattedText: Text

      if unformattedString ~= "<\\?xml version=\"1.0\" encoding=\"UTF-8\"\\?>" {
        formattedText = xmlTag()
      } else if unformattedString ~= doctype {
        formattedText = doctypeTag()
      } else if unformattedString ~= plist {
        formattedText = plistTag()
      } else if unformattedString ~= "<\\/?(plist|dict|array|key|true\\/|false\\/|data|date|integer|real|string)>" {
        formattedText = tag(for: unformattedString)
      } else if unformattedString ~= "<name>[\\s\\S]*<\\/name>" {
        formattedText = name(for: unformattedString)
      } else if unformattedString ~= "<value>[\\s\\S]*<\\/value>" {
        formattedText = value(for: unformattedString)
      } else {
        formattedText = Text(unformattedString)
      }

      // swiftlint:disable:next shorthand_operator
      propertyListText = propertyListText + formattedText
    }

    return propertyListText
  }

  var body: some View {
    propertyListText
      .font(.system(.body, design: .monospaced))
  }

  private func xmlTag() -> Text {
    return Text("<?xml ").foregroundColor(.pink) +
           Text("version").foregroundColor(.green) +
           Text("=").foregroundColor(.pink) +
           Text("\"").foregroundColor(.yellow) +
           Text("1.0") +
           Text("\" ").foregroundColor(.yellow) +
           Text("encoding").foregroundColor(.green) +
           Text("=").foregroundColor(.pink) +
           Text("\"").foregroundColor(.yellow) +
           Text("UTF-8") +
           Text("\"").foregroundColor(.yellow) +
           Text("?>").foregroundColor(.pink)
  }

  private func doctypeTag() -> Text {
    return Text("<!DOCTYPE ").foregroundColor(.pink) +
           Text("plist PUBLIC ") +
           Text("\"").foregroundColor(.yellow) +
           Text("-//Apple//DTD PLIST 1.0//EN") +
           Text("\" \"").foregroundColor(.yellow) +
           Text("http://www.apple.com/DTDs/PropertyList-1.0.dtd") +
           Text("\"").foregroundColor(.yellow) +
           Text(">").foregroundColor(.pink)
  }

  private func plistTag() -> Text {
    return Text("<plist ").foregroundColor(.pink) +
           Text("version").foregroundColor(.green) +
           Text("=").foregroundColor(.pink) +
           Text("\"").foregroundColor(.yellow) +
           Text("1.0") +
           Text("\"").foregroundColor(.yellow) +
           Text(">").foregroundColor(.pink)
  }

  private func tag(for string: String) -> Text {
    return Text(string)
      .foregroundColor(.pink)
  }

  private func name(for string: String) -> Text {
    let formattedString: String = string.replacingOccurrences(of: "<name>", with: "")
                                        .replacingOccurrences(of: "</name>", with: "")
    return Text(formattedString)
      .foregroundColor(.blue)
  }

  private func value(for string: String) -> Text {
    let formattedString: String = string.replacingOccurrences(of: "<value>", with: "")
                                        .replacingOccurrences(of: "</value>", with: "")
    return Text(formattedString)
  }
}
