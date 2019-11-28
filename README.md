# Sorcery

Helpers for iOS App development for UIKit and SwiftUI.

## New

## 0.0.15

- Make the `apply` requirement public

## 0.0.14

- Add an `apply` requirement for `RefluxState`, Remove `apply` requirement from `Store`.

## 0.0.13

- Add `Reflux`, a replacement for `SwiftUIFlux` that uses classes over structs

## 0.0.12

- Refactored Card View to use Stack, Column and Row
- Add Stack, Column and Row Views with improved simplicity and layout options over supplied ZStack, VStack and HStack.
- Fix EdgeReveal, refactored shadow as it was screwing with gesture's in List and ScrollView!

## 0.0.11

- Refactored Material colors from SwiftUI.Color to UIKit.Color. This allow for color transforms before they are converted to SwiftUI.Color.

## 0.0.10

- Add Material colors

## 0.0.9

- Refactored EdgeReveal to use an EnvironmentObject (EdgeRevealModel) for state
- Update Copyright info and include MIT license link

## 0.0.8

- Move repo to BitBucket

## 0.0.7

- Add common/extensions
- Add common/utilities Log, Alert
- Add swiftui/modifiers DragModifier, FillModifier
- Add swiftui/packages SwiftUIRouter
- Add swiftui/preferences RectPreferences
- Add swiftui/views Card, Fab, FullScreen, HSpacer, VSpacer, KeyboardHost, Symbol, SystemSymbol

## 0.0.6

- Add Picon View

## 0.0.5

- Add EdgeReveal View
- Add support for SwiftUI

## 0.0.4

- Change 'Color' to 'SorceryColor' as 'Color' conflicts with SwiftUI.Color

## 0.0.3

- Add Log.echo

## 0.0.2

- Add contrain to public accessability

## 0.0.1

- Initial release
