# Changelog

## [3.0.1](https://github.com/ninxsoft/Mist/releases/tag/v0.5) - 2022-03-15

- Fixed a bug that assumed no User Configuration Profiles were installed (thanks [dhcav](https://github.com/dhcav) for discovering this!)

## [3.0](https://github.com/ninxsoft/LowProfile/releases/tag/v3.0) - 2022-03-06

- Added support for installed configuration profiles (thanks [hkystar35](https://github.com/hkystar35) for the awesome suggestion!)
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

- Shiny new app icon (thanks [smithjw](https://github.com/smithjw))
- Added ability to copy most text components
- General code cleanup

## [0.1 Beta](https://github.com/ninxsoft/LowProfile/releases/tag/v0.1) - 2020-08-16

- Initial release
