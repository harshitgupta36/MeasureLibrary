# HHARCoreKit

`HHARCoreKit` is a binary Swift package for embedding an AR-based measurement flow inside an iOS app. It is designed for fast on-device measurements of lines and surface shapes such as triangles, quadrilaterals, and polygons, with a built-in share flow and localized UI resources.

The package appears to power the example app [Measure Pro AI](https://apps.apple.com/in/app/measure-pro-ai/id6642650935), which presents the same core use case: quick AR measurements for real-world spaces and objects.

## Highlights

- AR measurement workflow packaged as a reusable `.xcframework`
- SwiftUI entry point via `ARMeasureSwiftUIView`
- Configurable brand accent color through `HHARCoreKitConfig`
- Built-in support for line, triangle, quadrilateral, and polygon measurement modes
- Localized resources bundled for 29 languages
- Device and simulator slices included in the XCFramework

## Requirements

- Xcode with Swift Package Manager support
- iPhone or iPad hardware with ARKit support for real-world measurement
- Camera permission in the host app

## Installation

Add the package in Xcode using the repository URL, or point Swift Package Manager to this local package during development.

`Package.swift` exposes a single library product:

```swift
.library(
    name: "HHARCoreKit",
    targets: ["HHARCoreKit"]
)
```

## Public API

The current binary exposes a small public API surface:

### SwiftUI

```swift
import HHARCoreKit
import SwiftUI

struct MeasurementScreen: View {
    var body: some View {
        ARMeasureSwiftUIView {
            // Called when the embedded flow finishes or dismisses.
        }
        .ignoresSafeArea()
    }
}
```

### Global configuration

```swift
import HHARCoreKit
import UIKit

func configureMeasurementUI() {
    HHARCoreKitConfig.accentColor = .systemBlue
    HHARCoreKitConfig.isHideBackButton = false
}
```

### Storyboard access

The binary also exposes `AppStoryboard` for storyboard-based loading:

```swift
let storyboard = AppStoryboard.arMeasure.instance
let rootViewController = storyboard.initialViewController()
```

Use this path only if you specifically need UIKit-level control. For most apps, `ARMeasureSwiftUIView` is the simplest integration point.

## Host App Setup

Add a camera usage description to the host app's `Info.plist`:

```xml
<key>NSCameraUsageDescription</key>
<string>Camera access is required to measure real-world objects in AR.</string>
```

Recommended host-side checks:

- Run the flow only on ARKit-capable devices
- Present a fallback message when camera permission is denied
- Test measurement quality in well-lit environments with visible surfaces

## What The Embedded Flow Supports

Based on the shipped module interface, resources, and bundled strings, the measurement UI includes:

- Line measurement
- Triangle measurement
- Quadrilateral measurement
- Polygon measurement
- Area display
- Share action
- Tracking status feedback

## Compatibility Notes

There is an important versioning mismatch in the current package contents:

- `Package.swift` declares `.iOS(.v15)`
- The App Store example app currently lists `iOS 16.0 or later`
- The bundled XCFramework itself is built with `minos 26.0` metadata in both device and simulator slices

That means the package manifest is more permissive than the binary it currently ships. Before publishing this package for external use, validate the framework build settings and rebuild the XCFramework with the intended minimum deployment target.

## Recommended Release Checklist

- Align the XCFramework deployment target with the package manifest
- Add a minimal sample app showing SwiftUI integration
- Document whether `completionBack` fires on dismiss, export, or both
- Confirm which devices are officially supported
- Add release notes for binary version changes

## Repository Layout

```text
.
├── Package.swift
└── HHARCoreKit.xcframework
```

## Support

If you are distributing this package to other teams or clients, keep the README version in sync with each new XCFramework build. For binary packages, stale setup notes usually become the first integration failure point.
