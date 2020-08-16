
# Low Profile

A friendly Mac utility to help inspect Apple Configuration Profile [payloads](https://developer.apple.com/documentation/devicemanagement/profile-specific_payload_keys):

![Example](Readme%20Resources/Example.png)

*   [x] Want to know what a Configuration Profile will enforce / change on a device before actually installing one?
*   [x] Tired of having to manually un-sign Configuration Profiles, only to have to flex your XML parsing skills to find out what is inside?
*   [x] Maybe you just want to qualify that your MDM vendor is creating Configuration Profiles the way you expect?

If the answer is yes to any of the above, then **Low Profile** is the app for **you!**

## Features

*   [x] Displays details for all Apple [supported payloads](#supported-payloads):
    *   Description
    *   Payload Type
    *   Supported Platforms (iOS, macOS, tvOS, watchOS)
    *   Payload-specific information (ie. Identifier, UUID, Display Name, Organisation, etc.)
    *   Payload Availability
    *   Properties:
        *   Payload Properties (supported and in the payload)
        *   Available Properties (supported and not in the payload)
        *   Unknown Properties (unknown and in the payload)

    ![Payload](Readme%20Resources/Payload.png)

*   [x] Displays details for custom 3rd-party payloads:

    ![Custom](Readme%20Resources/Custom.png)

*   [x] Displays Property List keys for all payloads:

    ![Property List](Readme%20Resources/Property%20List.png)

*   [x] Displays certificate information for signed Configuration Profiles:

    ![Certificate](Readme%20Resources/Certificate.png)

## Build Requirements

*   Swift **5.3**.
*   Xcode **12.0**.
*   Runs on macOS Big Sur **11.0**.

## Download

Grab the latest version of **Low Profile** from the [releases page](https://github.com/ninxsoft/LowProfile/releases).

## Credits / Thank You

*   Project created and maintained by Nindi Gill ([ninxsoft](https://github.com/ninxsoft)).
*   Documentation and icons sourced from [here](https://developer.apple.com/documentation/devicemanagement) and [here](https://support.apple.com/en-au/guide/mdm/welcome/web).
*   Filippo Maguolo ([filom](https://github.com/filom)) for [AS1NDecoder](https://github.com/filom/ASN1Decoder), used in reading certificate data.
*   Marcus Ransom ([@marcusransom](https://twitter.com/marcusransom)) for the awesome app name.

## Version History

*   0.1 Beta
    *   Initial release

## License

    Copyright © 2020 Nindi Gill

    Permission is hereby granted, free of charge, to any person obtaining a copy
    of this software and associated documentation files (the "Software"), to deal
    in the Software without restriction, including without limitation the rights
    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
    copies of the Software, and to permit persons to whom the Software is
    furnished to do so, subject to the following conditions:

    The above copyright notice and this permission notice shall be included in all
    copies or substantial portions of the Software.

    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
    SOFTWARE.
