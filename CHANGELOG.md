# Changelog

## [4.0](https://github.com/ninxsoft/LowProfile/releases/tag/v4.0) - 2023-09-28

- Updated payloads to support the following operating systems:
  - iOS 17
  - iPadOS 17
  - macOS 14 Sonoma
  - tvOS 17
  - watchOS 10
- Added support for the following new payloads:
  - [CellularPrivateNetwork](https://developer.apple.com/documentation/devicemanagement/cellularprivatenetwork)
  - [Declarations](https://developer.apple.com/documentation/devicemanagement/declarations-t8t)
  - [Relay](https://developer.apple.com/documentation/devicemanagement/relay)
  - [ServiceManagementManagedLoginItems](https://developer.apple.com/documentation/devicemanagement/servicemanagementmanagedloginitems)
- Added support for identifying issues:
  - A list of known issues can be viewed via the Issues button located in the toolbar
  - Duplicated properties across payloads / profiles are listed in the Issues popover
  - Deprecated properties are also listed in the Issues popover
  - Click on an individual issue to view the payload property details
  - Thanks [kevinmcox](https://github.com/kevinmcox)!
- Added support for exporting Low Profile reports:
  - A report of installed profiles can be exported as a `.lowprofile` file via the Export button located in the toolbar
  - Reports can be opened by Low Profile on any Mac
  - Thanks [BigMacAdmin](https://github.com/BigMacAdmin)!
- Syntax highlighting for Property Lists has been rebuilt from the ground up:
  - Replaced custom code with [Highlightr](https://github.com/raspu/Highlightr) package, reducing load times significantly!
  - Supports themes, customizable via app Settings
  - Supports [dynamic appearance](https://support.apple.com/en-us/HT208976) (i.e. light mode / dark mode)
- Fixed a bug that prevented payload properties with unicode characters from loading correctly - thanks [hkystar35](https://github.com/hkystar35)!
- Fix a bug that displayed property value types incorrectly - thanks [kevinmcox](https://github.com/kevinmcox)!
- The Search bar now supports profile / payload names, identifiers and property keys
- Sidebars are now wider by default and can be resized
- Payload properties now indicate if they are deprecated
- An example Property List for each payload is now shown in the Discussion tab
- The Discussion tab is now hidden if it is empty
- The currently selected tab is now remembered when switching between profiles / payloads
- Text selection has been enabled for the app Settings
- Added the missing tooltip for each payload's "View Documentation" button
- Bumped [AS1NDecoder](https://github.com/filom/ASN1Decoder) version to **1.9.0**
- Bumped [Sparkle](https://github.com/sparkle-project/Sparkle) version to **2.5.0**
- Bumped [Yams](https://github.com/jpsim/Yams) version to **5.0.6**
- A whole bunch of minor cosmetic tweaks

**Note:** Version **4.0** requires **macOS Ventura 13** or later. If you need to run **Low Profile** on an older operating system, you can still use version **3.0.1**.

## [3.0.1](https://github.com/ninxsoft/LowProfile/releases/tag/v3.0.1) - 2022-03-15

- Fixed a bug that assumed no User Configuration Profiles were installed - thanks [dhcav](https://github.com/dhcav)!

## [3.0](https://github.com/ninxsoft/LowProfile/releases/tag/v3.0) - 2022-03-06

- Added support for installed configuration profiles - thanks [hkystar35](https://github.com/hkystar35)!
  - Installed configuration profiles are now shown by default when the app launches
  - Opening configuration profiles still behaves as expected
  - This feature requires access to `system_profiler`, therefore the [App Sandbox](https://developer.apple.com/documentation/security/app_sandbox) entitlement has been removed
- Added granular detail for Managed Preferences payloads
  - `PayloadContent` dictionaries now display with full detail
  - `PayloadContent` dictionaries are no longer categorised as Unknown Properties
- General code cleanup

## [2.0](https://github.com/ninxsoft/LowProfile/releases/tag/v2.0) - 2021-12-08

- Payload information is now downloaded dynamically
  - Switched from Property List to YAML format (smaller file size)
  - If unable to download payload information, default to app bundle
- Entire certificate chains are now shown for signed configuration profiles
- Added support for certificate data within payload properties
- Improved formatting of payload properties with custom arrays and dictionaries
- Low Profile will now check for updates on app launch
- Significant UI cleanup (condensed tabs and overlapping views)
- All text strings can be highlighted and copied to clipboard
- General code cleanup

## [1.0](https://github.com/ninxsoft/LowProfile/releases/tag/v1.0) - 2021-04-18

- Shiny new app icon - thanks [smithjw](https://github.com/smithjw)!
- Added ability to copy most text components
- General code cleanup

## [0.1 Beta](https://github.com/ninxsoft/LowProfile/releases/tag/v0.1) - 2020-08-16

- Initial release
