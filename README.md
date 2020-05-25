# Sorcery

Helpers for iOS App development for UIKit and SwiftUI. Built as a library and shared via the Swift Package Manager.

## New

## 0.0.52

- Add TriFlixStore, new simpler yet powerfull state management using closures for actions that mutate the single source of truth store. actions are batched for execution at end of frame and can provide custom logging messages.

## 0.0.51

- Refactored Reflux ( Order = ( Action: to change state, Command: that can disptach(Action) to change state )

## 0.0.50

- Improve spacing in Column()

## 0.0.49

- Add support from alignmentGuides in Row() and Column()

## 0.0.48

- Add Spacer(minLength: 0) to Column() and Row() Views

## 0.0.47

- Reenable Log.error() to Alert()
- FullFrame(), to use instead of Color.clear
- Stack, add Color.clear as an optional.   Stack(expanded: true)

## 0.0.46

- Add Pad(width:, height:) for adding sized padding/spacing. Use to replace VSpacer() and HSpacer()
- Reinstated DispatchQueue.main.async in Reflux

## 0.0.45

- Remove DispatchQueue.main.async in Reflux for performance testing
- Fix Stack, remove Color.clear

## 0.0.44

- Card
- ItemCache
- CachedImage
- ImageLoader

## 0.0.43

- Removed Logging from Data+Formatting

## 0.0.42

- Rewrite 'Reflux' to allow for Protocols in Generics. Allows for mock store and mock service. 
- This breaks all Async actions, new version ( Replace <> with domain content )
```class <Action>: Async {
    func apply(reflux: AnyObject) {
        guard let reflux = reflux as? <App>Reflux else { return }
        <Preform Async Actions>
    }
}
```

## 0.0.41

- Fix: color conversion from hexString with alpha. 
- New UIColor.init(fromHex: String) and UIColor.toHex(…)
- Removed UIColor.toRGBString(…)

## 0.0.40

- Make Stack View compatible with ZStack View 

## 0.0.39

- Make UIColor HEX functions public, so that they can be used outside the library! 

## 0.0.38

- Add UIColor HEX conversions that include optional alpha

## 0.0.37

- Refactored Reflux naming to align better with Redux. 
- Store.apply() is now Store.reducer() 
- Reflux.middleman is now Reflux.middleware

## 0.0.36

- Add logging routing for console and server placeholder.

## 0.0.35

- Make accessible: UIPanGestureRecognizer & UIPinchGestureRecognizer

## 0.0.34

- Improved naming convention for Store based objects.

## 0.0.33

- Update documentation for `Reflux` state management package.

## 0.0.32

- Refined Reflux implementation of Flux and Redux.

## 0.0.31

- Remove `ReflectedStringConvertible` from `AsyncAction`. `AsyncAction` implements `Action` which already implements `ReflectedStringConvertible`

## 0.0.30

- Add `ReflectedStringConvertible` to `AsyncAction`

## 0.0.29

- Add `ReflectedStringConvertible` protocol

## 0.0.28

- Refactor `ConnectedView` to pass services tp the `map` function. This removes the need to provide `typealias` in the struct.

## 0.0.27

- Add `Services` as a Generic. Side effect, all `ConnectedViews` need to provide `typealias Services = AppServices`

## 0.0.26

- Create a `MockCoreServices` to act as a `Nil`
- Add `CoreServices` to the `Store`

## 0.0.25

- Renamed `store.dispatch(action: Action)` to `store.dispatch(_ action: Action)` 

## 0.0.24

- Add public init to `Command`

## 0.0.23

- Reduce number default `Command/Response` types

## 0.0.22

- Add open init's to all `Command/Response` interfaces

## 0.0.21

- Make all `Command/Response` interfaces `open/public`

## 0.0.20

- Make  `Command` / `Response`  open 

## 0.0.19

- Add `Command` / `Response` for use by `Components`


## 0.0.18

- Remove `Command` / `Response`

## 0.0.17

- Expose model public offerings

## 0.0.16

- Whoops, remove the `apply` requirement public

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
