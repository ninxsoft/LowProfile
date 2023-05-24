### :mega: Layoffs are less than ideal

I am a seasoned Mac Sys Admin who also makes Mac apps in Swift :hammer_and_wrench:

If you feel I would be a great fit for any job opportunities, please don't hesitate to reach out: [nindi@ninxsoft.com](mailto:nindi@ninxsoft.com) | [LinkedIn](https://www.linkedin.com/in/nindigill/)

Thank you :bow:

---

<img align="left" width="128" height="128" src="Readme%20Resources/App%20Icon.png">

# Low Profile

![Latest Release](https://img.shields.io/github/v/release/ninxsoft/LowProfile?display_name=tag&label=Latest%20Release&sort=semver) ![Downloads](https://img.shields.io/github/downloads/ninxsoft/LowProfile/total?label=Downloads) [![Linting](https://github.com/ninxsoft/LowProfile/actions/workflows/linting.yml/badge.svg)](https://github.com/ninxsoft/LowProfile/actions/workflows/linting.yml) [![Unit Tests](https://github.com/ninxsoft/LowProfile/actions/workflows/unit_tests.yml/badge.svg)](https://github.com/ninxsoft/LowProfile/actions/workflows/unit_tests.yml) [![Build](https://github.com/ninxsoft/LowProfile/actions/workflows/build.yml/badge.svg)](https://github.com/ninxsoft/LowProfile/actions/workflows/build.yml)

A Mac utility to help inspect Apple Configuration Profile [payloads](https://developer.apple.com/documentation/devicemanagement/profile-specific_payload_keys):

![Example](Readme%20Resources/Example.png)

- [x] Want to see what is inside the Configuration Profiles that are installed on your Mac?
- [x] Curious to know what a Configuration Profile will enforce / change on a device before actually installing one?
- [x] Tired of having to manually un-sign Configuration Profiles, only to have to flex your XML parsing skills to find out what is inside?
- [x] Maybe you just want to qualify that your MDM vendor is creating Configuration Profiles the way you expect?

If the answer is yes to any of the above, then **Low Profile** is the app for **you!**

## Features

- [x] Displays details for all Apple [supported payloads](https://developer.apple.com/documentation/devicemanagement/profile-specific_payload_keys):

  - Description + Payload Type
  - Supported Platforms (iOS, iPadOS, macOS, tvOS, watchOS)
  - Payload-specific information (ie. Identifier, UUID, Display Name, Organisation, etc.)
  - Payload Availability
  - Properties:

    - Payload Properties (supported and in the payload)
    - Available Properties (supported and not in the payload)
    - Unknown Properties (unknown and in the payload)

    ![Payload](Readme%20Resources/Payload.png)

- [x] Displays Property List keys for all payloads:

  ![Property List](Readme%20Resources/Property%20List.png)

- [x] Displays nested payloads for Managed Preferences:

  ![Certificate](Readme%20Resources/Managed%20Preferences.png)

- [x] Displays details for custom 3rd-party payloads:

  - Including certificate data
  - Including custom arrays and dictionaries

  ![Custom](Readme%20Resources/Custom.png)

- [x] Displays certificate information for signed Configuration Profiles:

  ![Certificate](Readme%20Resources/Certificate.png)

## Build Requirements

- Swift **5.5** | Xcode **13.0**.
- Runs on macOS Monterey **12.0** and later.

## Download

Grab the latest version of **Low Profile** from the [releases page](https://github.com/ninxsoft/LowProfile/releases).

## Credits / Thank You

- Project created and maintained by Nindi Gill ([ninxsoft](https://github.com/ninxsoft)).
- Documentation and icons sourced from [here](https://developer.apple.com/documentation/devicemanagement) and [here](https://support.apple.com/en-au/guide/mdm/welcome/web).
- Filippo Maguolo ([filom](https://github.com/filom)) for [AS1NDecoder](https://github.com/filom/ASN1Decoder), used in reading certificate data.
- JP Simard ([jpsim](https://github.com/jpsim)) for [Yams](https://github.com/jpsim/Yams), used to import YAML.
- Marcus Ransom ([@marcusransom](https://twitter.com/marcusransom)) for the awesome app name.
- James Smith ([smithjw](https://github.com/smithjw)) for the shiny new app icon.

## License

> Copyright © 2023 Nindi Gill
>
> Permission is hereby granted, free of charge, to any person obtaining a copy
> of this software and associated documentation files (the "Software"), to deal
> in the Software without restriction, including without limitation the rights
> to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
> copies of the Software, and to permit persons to whom the Software is
> furnished to do so, subject to the following conditions:
>
> The above copyright notice and this permission notice shall be included in all
> copies or substantial portions of the Software.
>
> THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
> AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
> LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
> OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
> SOFTWARE.
